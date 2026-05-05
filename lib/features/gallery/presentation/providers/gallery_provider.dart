import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/video_model.dart';
import '../../../../core/services/analytics_service.dart';

class GalleryProvider extends ChangeNotifier {
  final Box<VideoRecord> _videoBox;
  List<VideoRecord>? _cachedVideos;

  GalleryProvider(this._videoBox);

  List<VideoRecord> get videos {
    final cached = _cachedVideos;
    if (cached != null) return cached;
    final computed = _videoBox.values.toList().reversed.toList(growable: false);
    _cachedVideos = computed;
    return computed;
  }

  void _invalidateCache() {
    _cachedVideos = null;
  }

  void addVideo(String path) {
    final video = VideoRecord(path: path, date: DateTime.now());
    _videoBox.add(video).then((_) {
      int size = 0;
      try {
        size = File(path).lengthSync();
      } catch (_) {}

      AnalyticsService().logVideoSaved(
        videoId: video.key?.toString() ?? 'new',
        scriptId: 'unknown',
        durationSeconds: 0,
        fileSizeBytes: size,
      );
      _invalidateCache();
      notifyListeners();
    });
  }

  /// One notification after all rows — used by cloud restore.
  Future<void> importVideosFromRestore(List<VideoRecord> restored) async {
    if (restored.isEmpty) return;
    for (final record in restored) {
      final video = VideoRecord(path: record.path, date: record.date);
      await _videoBox.add(video);
      int size = 0;
      try {
        size = File(record.path).lengthSync();
      } catch (_) {}
      AnalyticsService().logVideoSaved(
        videoId: video.key?.toString() ?? 'new',
        scriptId: 'unknown',
        durationSeconds: 0,
        fileSizeBytes: size,
      );
    }
    _invalidateCache();
    notifyListeners();
  }

  Future<void> deleteVideo(VideoRecord video) async {
    try {
      final file = File(video.path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint("Error deleting physical file: $e");
    }

    AnalyticsService().logVideoDeleted(
      videoId: video.key?.toString() ?? 'unknown',
      durationSeconds: 0,
    );
    await video.delete();
    _invalidateCache();
    notifyListeners();
  }
}
