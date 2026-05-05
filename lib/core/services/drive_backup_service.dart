import 'dart:convert';
import 'dart:io';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path_provider/path_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_application_6/core/services/google_auth_service.dart';
import 'package:flutter_application_6/core/services/backup/manifest_handler.dart';
import 'package:flutter_application_6/core/services/backup/video_backup_handler.dart';
import 'package:flutter_application_6/features/scripts/data/models/script_model.dart';
import 'package:flutter_application_6/features/gallery/data/models/video_model.dart';

class DriveBackupService {
  final GoogleAuthService _authService = GoogleAuthService();
  static const String _manifestFileName = 'backup_manifest_v1.json';
  static const String _videosFolderName = 'videos';

  Future<void> backup({
    required List<Script> scripts,
    required List<VideoRecord> videos,
    required Map<String, dynamic> settings,
    Function(double)? onProgress,
  }) async {
    final client = await _authService.getAuthenticatedClient();
    if (client == null) throw Exception('Not authenticated');

    final driveApi = drive.DriveApi(client);
    final videoHandler = VideoBackupHandler(driveApi);

    // 1. Ensure /videos/ folder exists in appDataFolder
    final videosFolderId = await _getOrCreateFolder(
      driveApi,
      _videosFolderName,
    );

    // 2. Upload videos first
    int uploadedCount = 0;
    for (final video in videos) {
      final file = File(video.path);
      if (await file.exists()) {
        await videoHandler.uploadVideo(file, videosFolderId);
      }
      uploadedCount++;
      if (onProgress != null) {
        onProgress(uploadedCount / (videos.length + 1));
      }
    }

    // 3. Generate and upload manifest
    final packageInfo = await PackageInfo.fromPlatform();
    final manifestJson = ManifestHandler.generateManifest(
      scripts: scripts,
      videos: videos,
      settings: settings,
      appVersion: packageInfo.version,
    );

    await _uploadManifest(driveApi, manifestJson);

    if (onProgress != null) {
      onProgress(1.0);
    }
  }

  Future<Map<String, dynamic>?> restore() async {
    final client = await _authService.getAuthenticatedClient();
    if (client == null) throw Exception('Not authenticated');

    final driveApi = drive.DriveApi(client);
    final videoHandler = VideoBackupHandler(driveApi);

    // 1. Download manifest
    final manifestFile = await _findFileInAppData(driveApi, _manifestFileName);
    if (manifestFile == null || manifestFile.id == null) return null;

    final media =
        await driveApi.files.get(
              manifestFile.id!,
              downloadOptions: drive.DownloadOptions.fullMedia,
            )
            as drive.Media;

    final List<int> data = [];
    await for (final chunk in media.stream) {
      data.addAll(chunk);
    }
    final manifestJson = utf8.decode(data);
    final manifest = ManifestHandler.parseManifest(manifestJson);

    // 2. Download missing videos
    final videosFolderId = await _getOrCreateFolder(
      driveApi,
      _videosFolderName,
    );
    final manifestVideos = ManifestHandler.getVideos(manifest);

    // Get application documents directory to save videos
    final appDocDir = await getApplicationDocumentsDirectory();

    for (final video in manifestVideos) {
      final fileName = video.path.split('/').last;
      final localPath = '${appDocDir.path}/$fileName';
      final localFile = File(localPath);

      if (!await localFile.exists()) {
        await videoHandler.downloadVideo(fileName, videosFolderId, localPath);
        // Update video path to local path for restoration
        video.path = localPath;
      }
    }

    return manifest;
  }

  Future<String> _getOrCreateFolder(
    drive.DriveApi driveApi,
    String folderName,
  ) async {
    final response = await driveApi.files.list(
      q: "name = '$folderName' and mimeType = 'application/vnd.google-apps.folder'",
      spaces: 'appDataFolder',
    );

    if (response.files != null && response.files!.isNotEmpty) {
      return response.files!.first.id!;
    }

    final driveFile = drive.File()
      ..name = folderName
      ..mimeType = 'application/vnd.google-apps.folder'
      ..parents = ['appDataFolder'];

    final createdFile = await driveApi.files.create(driveFile);
    return createdFile.id!;
  }

  Future<void> _uploadManifest(drive.DriveApi driveApi, String json) async {
    final existingManifest = await _findFileInAppData(
      driveApi,
      _manifestFileName,
    );

    final driveFile = drive.File()
      ..name = _manifestFileName
      ..parents = ['appDataFolder'];

    final media = drive.Media(Stream.value(utf8.encode(json)), json.length);

    if (existingManifest != null && existingManifest.id != null) {
      await driveApi.files.update(
        drive.File(), // We only need name for new, but here we update by ID
        existingManifest.id!,
        uploadMedia: media,
      );
    } else {
      await driveApi.files.create(driveFile, uploadMedia: media);
    }
  }

  Future<drive.File?> _findFileInAppData(
    drive.DriveApi driveApi,
    String name,
  ) async {
    final response = await driveApi.files.list(
      q: "name = '$name'",
      spaces: 'appDataFolder',
    );
    if (response.files != null && response.files!.isNotEmpty) {
      return response.files!.first;
    }
    return null;
  }

  Future<Map<String, String>?> getLastBackupInfo() async {
    try {
      final client = await _authService.getAuthenticatedClient();
      if (client == null) return null;

      final driveApi = drive.DriveApi(client);
      final manifestFile = await _findFileInAppData(
        driveApi,
        _manifestFileName,
      );

      if (manifestFile == null || manifestFile.id == null) return null;

      // We need to fetch the manifest to get the timestamp inside it
      // or just use modifiedTime from Drive but manifest timestamp is more accurate for "app backup"
      final media =
          await driveApi.files.get(
                manifestFile.id!,
                downloadOptions: drive.DownloadOptions.fullMedia,
              )
              as drive.Media;

      final List<int> data = [];
      await for (final chunk in media.stream) {
        data.addAll(chunk);
      }
      final manifest = jsonDecode(utf8.decode(data));

      return {
        'timestamp': manifest['timestamp'] ?? '',
        'size': manifestFile.size ?? '0',
      };
    } catch (_) {
      return null;
    }
  }
}
