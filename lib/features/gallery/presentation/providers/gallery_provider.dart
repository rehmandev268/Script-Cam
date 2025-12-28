import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/video_model.dart';

class GalleryProvider extends ChangeNotifier {
  final Box<VideoRecord> _videoBox;

  GalleryProvider(this._videoBox);

  List<VideoRecord> get videos => _videoBox.values.toList().reversed.toList();

  void addVideo(String path) {
    _videoBox.add(VideoRecord(path: path, date: DateTime.now()));
    notifyListeners();
  }

  void deleteVideo(VideoRecord video) {
    video.delete();
    notifyListeners();
  }
}
