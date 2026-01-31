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

  void deleteVideo(VideoRecord video) {
    AnalyticsService().logVideoDeleted(
      videoId: video.key?.toString() ?? 'unknown',
      durationSeconds: 0, // Duration not available in model
    );
    video.delete();
    notifyListeners();
  }
}
