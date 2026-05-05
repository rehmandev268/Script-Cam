import 'dart:convert';
import 'package:flutter_application_6/features/scripts/data/models/script_model.dart';
import 'package:flutter_application_6/features/gallery/data/models/video_model.dart';

class ManifestHandler {
  static const int schemaVersion = 1;

  static String generateManifest({
    required List<Script> scripts,
    required List<VideoRecord> videos,
    required Map<String, dynamic> settings,
    required String appVersion,
  }) {
    final manifest = {
      'schemaVersion': schemaVersion,
      'appVersion': appVersion,
      'timestamp': DateTime.now().toIso8601String(),
      'scripts': scripts.map((s) => s.toMap()).toList(),
      'videos': videos.map((v) => v.toMap()).toList(),
      'settings': settings,
    };
    return jsonEncode(manifest);
  }

  static Map<String, dynamic> parseManifest(String json) {
    return jsonDecode(json);
  }

  static List<Script> getScripts(Map<String, dynamic> manifest) {
    final List<dynamic> scriptsList = manifest['scripts'] ?? [];
    return scriptsList
        .map((s) => Script.fromMap(s as Map<String, dynamic>))
        .toList();
  }

  static List<VideoRecord> getVideos(Map<String, dynamic> manifest) {
    final List<dynamic> videosList = manifest['videos'] ?? [];
    return videosList
        .map((v) => VideoRecord.fromMap(v as Map<String, dynamic>))
        .toList();
  }

  static Map<String, dynamic> getSettings(Map<String, dynamic> manifest) {
    return manifest['settings'] ?? {};
  }
}
