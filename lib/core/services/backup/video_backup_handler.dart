import 'dart:io';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart' as p;

class VideoBackupHandler {
  final drive.DriveApi _driveApi;

  VideoBackupHandler(this._driveApi);

  Future<void> uploadVideo(File videoFile, String folderId) async {
    final fileName = p.basename(videoFile.path);
    final size = await videoFile.length();

    // Check if file already exists in the appDataFolder with same name and size
    final existingFile = await _findFileInFolder(fileName, folderId);
    if (existingFile != null &&
        int.tryParse(existingFile.size ?? '0') == size) {
      return; // Skip already uploaded
    }

    final driveFile = drive.File()
      ..name = fileName
      ..parents = [folderId];

    final media = drive.Media(videoFile.openRead(), size);

    // Use resumable upload for files > 10MB
    await _driveApi.files.create(driveFile, uploadMedia: media);
  }

  Future<void> downloadVideo(
    String fileName,
    String folderId,
    String localPath,
  ) async {
    final driveFile = await _findFileInFolder(fileName, folderId);
    if (driveFile == null || driveFile.id == null) return;

    // We actually need the full media content, not just metadata
    final media =
        await _driveApi.files.get(
              driveFile.id!,
              downloadOptions: drive.DownloadOptions.fullMedia,
            )
            as drive.Media;

    final file = File(localPath);
    final IOSink sink = file.openWrite();
    await media.stream.pipe(sink);
    await sink.close();
  }

  Future<drive.File?> _findFileInFolder(String name, String folderId) async {
    final response = await _driveApi.files.list(
      q: "name = '$name' and '$folderId' in parents",
      spaces: 'appDataFolder',
    );
    if (response.files != null && response.files!.isNotEmpty) {
      return response.files!.first;
    }
    return null;
  }

  Future<List<drive.File>> listFiles(String folderId) async {
    final response = await _driveApi.files.list(
      q: "'$folderId' in parents",
      spaces: 'appDataFolder',
    );
    return response.files ?? [];
  }
}
