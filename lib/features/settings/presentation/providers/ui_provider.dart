import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/services/analytics_service.dart';

class UIProvider extends ChangeNotifier {
  final Box _settingsBox;
  bool _showOnboarding = true;
  bool get showOnboarding => _showOnboarding;
  bool _showcaseSeen = false;
  bool get showcaseSeen => _showcaseSeen;
  bool _permissionsGranted = false;
  bool get permissionsGranted => _permissionsGranted;

  bool _voiceSyncEnabled = false;
  bool get voiceSyncEnabled => _voiceSyncEnabled;

  bool _mirrorTextEnabled = false;
  bool get mirrorTextEnabled => _mirrorTextEnabled;

  bool _languageSelected = false;
  bool get languageSelected => _languageSelected;

  UIProvider(this._settingsBox) {
    _checkLanguageSelection();
    _checkOnboarding();
    _checkShowcase();
    _loadVoiceSyncSetting();
    _loadMirrorTextSetting();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    final camera = await Permission.camera.isGranted;
    final mic = await Permission.microphone.isGranted;
    _permissionsGranted = camera && mic;
    notifyListeners();
  }

  void _checkOnboarding() {
    final seen = _settingsBox.get('onboarding_seen', defaultValue: false);
    _showOnboarding = !seen;
    notifyListeners();
  }

  void _checkShowcase() {
    _showcaseSeen = _settingsBox.get('showcase_seen', defaultValue: false);
    notifyListeners();
  }

  void _loadVoiceSyncSetting() {
    _voiceSyncEnabled = _settingsBox.get(
      'voice_sync_enabled',
      defaultValue: false,
    );
    notifyListeners();
  }

  void _loadMirrorTextSetting() {
    _mirrorTextEnabled = _settingsBox.get(
      'mirror_text_enabled',
      defaultValue: false,
    );
    notifyListeners();
  }

  void toggleVoiceSync(bool value) {
    _voiceSyncEnabled = value;
    _settingsBox.put('voice_sync_enabled', value);
    AnalyticsService().logVoiceSyncToggled(enabled: value);
    notifyListeners();
  }

  void toggleMirrorText(bool value) {
    _mirrorTextEnabled = value;
    _settingsBox.put('mirror_text_enabled', value);
    AnalyticsService().logMirrorTextToggled(enabled: value);
    notifyListeners();
  }

  void completeOnboarding() {
    _settingsBox.put('onboarding_seen', true);
    _showOnboarding = false;
    AnalyticsService().logOnboardingCompleted();
    notifyListeners();
  }

  void completeShowcase() {
    _settingsBox.put('showcase_seen', true);
    _showcaseSeen = true;
    notifyListeners();
  }

  void _checkLanguageSelection() {
    _languageSelected = _settingsBox.get(
      'language_selected',
      defaultValue: false,
    );
    notifyListeners();
  }

  void completeLanguageSelection() {
    _settingsBox.put('language_selected', true);
    _languageSelected = true;
    notifyListeners();
  }
}
