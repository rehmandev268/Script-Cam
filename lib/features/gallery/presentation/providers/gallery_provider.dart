import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/video_model.dart';
import '../../../../core/services/analytics_service.dart';

class GalleryProvider extends ChangeNotifier {
  final Box<VideoRecord> _videoBox;

  GalleryProvider(this._videoBox);

  List<VideoRecord> get videos => _videoBox.values.toList().reversed.toList();

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
    });
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
    video.delete();
    notifyListeners();
  }
}
