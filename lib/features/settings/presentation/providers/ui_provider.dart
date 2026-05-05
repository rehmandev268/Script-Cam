import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import '../../../../core/services/analytics_service.dart';

const List<String> kPrompterFontFamilies = [
  'Default',
  'Manrope',
  'Roboto Mono',
  'Playfair Display',
  'Oswald',
  'Lato',
];

class UIProvider extends ChangeNotifier {
  final Box _settingsBox;
  Timer? _settingsWriteTimer;
  final Map<String, dynamic> _pendingSettingsWrites = {};
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

  bool _focusLineEnabled = false;
  bool get focusLineEnabled => _focusLineEnabled;

  bool _cueCardModeEnabled = false;
  bool get cueCardModeEnabled => _cueCardModeEnabled;

  double _lineSpacing = 1.4;
  double get lineSpacing => _lineSpacing;

  bool _languageSelected = false;
  bool get languageSelected => _languageSelected;

  int _countdownDuration = 3;
  int get countdownDuration => _countdownDuration;

  bool _autoBackupEnabled = false;
  bool get autoBackupEnabled => _autoBackupEnabled;

  bool _backupVideosEnabled = false;
  bool get backupVideosEnabled => _backupVideosEnabled;

  bool _wifiOnlyBackup = true;
  bool get wifiOnlyBackup => _wifiOnlyBackup;

  String _lastBackupTime = "";
  String get lastBackupTime => _lastBackupTime;

  String _lastRestoreTime = "";
  String get lastRestoreTime => _lastRestoreTime;

  String _lastConnectedEmail = "";
  String get lastConnectedEmail => _lastConnectedEmail;

  String _lastConnectedName = "";
  String get lastConnectedName => _lastConnectedName;

  String _lastConnectedPhotoUrl = "";
  String get lastConnectedPhotoUrl => _lastConnectedPhotoUrl;

  double _prompterFontSize = 24.0;
  double get prompterFontSize => _prompterFontSize;

  double _prompterOpacity = 0.2;
  double get prompterOpacity => _prompterOpacity;

  double _prompterScrollSpeed = 50.0;
  double get prompterScrollSpeed => _prompterScrollSpeed;

  bool _defaultFrontCamera = true;
  bool get defaultFrontCamera => _defaultFrontCamera;

  String _defaultExportQuality = "fhd";
  String get defaultExportQuality => _defaultExportQuality;

  int _prompterTextOrientation = 0;
  int get prompterTextOrientation => _prompterTextOrientation;

  String _prompterFontFamily = 'Default';
  String get prompterFontFamily => _prompterFontFamily;

  // 0xFFFFFFFF stored as int; default white text, black bg
  int _prompterTextColor = 0xFFFFFFFF;
  int get prompterTextColor => _prompterTextColor;

  int _prompterBgColor = 0xFF000000;
  int get prompterBgColor => _prompterBgColor;

  // 0.0 = narrow (60%), 0.5 = medium (80%), 1.0 = full (100%)
  double _prompterColumnWidth = 1.0;
  double get prompterColumnWidth => _prompterColumnWidth;

  bool _prompterLoopEnabled = false;
  bool get prompterLoopEnabled => _prompterLoopEnabled;

  bool _prompterSoftStartEnabled = true;
  bool get prompterSoftStartEnabled => _prompterSoftStartEnabled;

  double _prompterWidth = 0.0;
  double get prompterWidth => _prompterWidth;

  double _prompterHeight = 0.0;
  double get prompterHeight => _prompterHeight;

  double _prompterX = 0.0;
  double get prompterX => _prompterX;

  double _prompterY = 0.0;
  double get prompterY => _prompterY;

  UIProvider(this._settingsBox) {
    _checkLanguageSelection();
    _checkOnboarding();
    _checkShowcase();
    _loadVoiceSyncSetting();
    _loadMirrorTextSetting();
    _loadFocusLineSetting();
    _loadCueCardModeSetting();
    _loadLineSpacingSetting();
    _loadCountdownSetting();
    _loadBackupSettings();
    _loadTeleprompterSettings();
    _loadRecordingDefaults();
    checkPermissions();
  }

  void _notifySafely() {
    final phase = SchedulerBinding.instance.schedulerPhase;
    if (phase == SchedulerPhase.idle ||
        phase == SchedulerPhase.postFrameCallbacks) {
      notifyListeners();
      return;
    }
    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
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

  void _loadFocusLineSetting() {
    _focusLineEnabled = _settingsBox.get(
      'focus_line_enabled',
      defaultValue: false,
    );
    notifyListeners();
  }

  void toggleFocusLine(bool value) {
    _focusLineEnabled = value;
    _settingsBox.put('focus_line_enabled', value);
    AnalyticsService().logFocusLineToggled(enabled: value);
    notifyListeners();
  }

  void _loadCueCardModeSetting() {
    _cueCardModeEnabled = _settingsBox.get('cue_card_mode_enabled', defaultValue: false);
  }

  void toggleCueCardMode(bool value) {
    _cueCardModeEnabled = value;
    _settingsBox.put('cue_card_mode_enabled', value);
    notifyListeners();
  }

  void _loadLineSpacingSetting() {
    _lineSpacing = _settingsBox.get('line_spacing', defaultValue: 1.4);
    notifyListeners();
  }

  void setLineSpacing(double value) {
    _lineSpacing = value;
    _settingsBox.put('line_spacing', value);
    AnalyticsService().logLineSpacingChanged(spacing: value);
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

  void _loadCountdownSetting() {
    _countdownDuration = _settingsBox.get(
      'countdown_duration',
      defaultValue: 3,
    );
    notifyListeners();
  }

  void setCountdownDuration(int duration) {
    _countdownDuration = duration;
    _settingsBox.put('countdown_duration', duration);
    AnalyticsService().logCountdownDurationChanged(duration: duration);
    notifyListeners();
  }

  void _loadBackupSettings() {
    _autoBackupEnabled = _settingsBox.get(
      'auto_backup_enabled',
      defaultValue: false,
    );
    _backupVideosEnabled = _settingsBox.get(
      'backup_videos_enabled',
      defaultValue: false,
    );
    _wifiOnlyBackup = _settingsBox.get('wifi_only_backup', defaultValue: true);
    _lastBackupTime = _settingsBox.get('last_backup_time', defaultValue: "");
    _lastRestoreTime = _settingsBox.get('last_restore_time', defaultValue: "");
    _lastConnectedEmail = _settingsBox.get('connected_email', defaultValue: "");
    _lastConnectedName = _settingsBox.get('connected_name', defaultValue: "");
    _lastConnectedPhotoUrl = _settingsBox.get(
      'connected_photo_url',
      defaultValue: "",
    );
    notifyListeners();
  }

  void setAutoBackup(bool value) {
    _autoBackupEnabled = value;
    _settingsBox.put('auto_backup_enabled', value);
    AnalyticsService().logAutoBackupToggled(enabled: value);
    notifyListeners();
  }

  void setBackupVideos(bool value) {
    _backupVideosEnabled = value;
    _settingsBox.put('backup_videos_enabled', value);
    AnalyticsService().logBackupVideosToggled(enabled: value);
    notifyListeners();
  }

  void setWifiOnlyBackup(bool value) {
    _wifiOnlyBackup = value;
    _settingsBox.put('wifi_only_backup', value);
    AnalyticsService().logWifiOnlyBackupToggled(enabled: value);
    notifyListeners();
  }

  void updateLastBackupTime(String time) {
    _lastBackupTime = time;
    _settingsBox.put('last_backup_time', time);
    notifyListeners();
  }

  void updateLastRestoreTime(String time) {
    _lastRestoreTime = time;
    _settingsBox.put('last_restore_time', time);
    notifyListeners();
  }

  void updateConnectedAccount({
    required String email,
    required String name,
    required String photoUrl,
  }) {
    _lastConnectedEmail = email;
    _lastConnectedName = name;
    _lastConnectedPhotoUrl = photoUrl;
    _settingsBox.put('connected_email', email);
    _settingsBox.put('connected_name', name);
    _settingsBox.put('connected_photo_url', photoUrl);
    notifyListeners();
  }

  void clearConnectedAccount() {
    _lastConnectedEmail = "";
    _lastConnectedName = "";
    _lastConnectedPhotoUrl = "";
    _settingsBox.delete('connected_email');
    _settingsBox.delete('connected_name');
    _settingsBox.delete('connected_photo_url');
    notifyListeners();
  }

  void _loadTeleprompterSettings() {
    _prompterFontSize = _settingsBox.get(
      'prompter_font_size',
      defaultValue: 24.0,
    );
    _prompterOpacity = _settingsBox.get('prompter_opacity', defaultValue: 0.2);
    _prompterScrollSpeed = _settingsBox.get(
      'prompter_scroll_speed',
      defaultValue: 50.0,
    );
    _prompterTextOrientation = _settingsBox.get(
      'prompter_text_orientation',
      defaultValue: 0,
    );
    _prompterWidth = _settingsBox.get('prompter_width', defaultValue: 0.0);
    _prompterHeight = _settingsBox.get('prompter_height', defaultValue: 0.0);
    _prompterX = _settingsBox.get('prompter_x', defaultValue: 0.0);
    _prompterY = _settingsBox.get('prompter_y', defaultValue: 0.0);
    _prompterFontFamily = _settingsBox.get(
      'prompter_font_family',
      defaultValue: 'Default',
    );
    _prompterTextColor = _settingsBox.get(
      'prompter_text_color',
      defaultValue: 0xFFFFFFFF,
    );
    _prompterBgColor = _settingsBox.get(
      'prompter_bg_color',
      defaultValue: 0xFF000000,
    );
    _prompterColumnWidth = _settingsBox.get(
      'prompter_column_width',
      defaultValue: 1.0,
    );
    _prompterLoopEnabled = _settingsBox.get(
      'prompter_loop_enabled',
      defaultValue: false,
    );
    _prompterSoftStartEnabled = _settingsBox.get(
      'prompter_soft_start_enabled',
      defaultValue: true,
    );
    notifyListeners();
  }

  void setPrompterFontFamily(String family) {
    _prompterFontFamily = family;
    _settingsBox.put('prompter_font_family', family);
    notifyListeners();
  }

  void setPrompterTextColor(int color) {
    _prompterTextColor = color;
    _settingsBox.put('prompter_text_color', color);
    notifyListeners();
  }

  void setPrompterBgColor(int color) {
    _prompterBgColor = color;
    _settingsBox.put('prompter_bg_color', color);
    notifyListeners();
  }

  void setPrompterColumnWidth(double value) {
    _prompterColumnWidth = value;
    _settingsBox.put('prompter_column_width', value);
    notifyListeners();
  }

  void togglePrompterLoop(bool value) {
    _prompterLoopEnabled = value;
    _settingsBox.put('prompter_loop_enabled', value);
    notifyListeners();
  }

  void togglePrompterSoftStart(bool value) {
    _prompterSoftStartEnabled = value;
    _settingsBox.put('prompter_soft_start_enabled', value);
    notifyListeners();
  }

  void setPrompterFontSize(double size) {
    _prompterFontSize = size;
    _scheduleSettingWrite('prompter_font_size', size);
    _notifySafely();
  }

  void setPrompterOpacity(double opacity) {
    _prompterOpacity = opacity;
    _scheduleSettingWrite('prompter_opacity', opacity);
    _notifySafely();
  }

  void setPrompterScrollSpeed(double speed) {
    _prompterScrollSpeed = speed;
    _scheduleSettingWrite('prompter_scroll_speed', speed);
    _notifySafely();
  }

  void setDefaultCamera(bool useFrontCamera) {
    _defaultFrontCamera = useFrontCamera;
    _settingsBox.put('default_front_camera', useFrontCamera);
    notifyListeners();
  }

  void setDefaultExportQuality(String quality) {
    _defaultExportQuality = quality;
    _settingsBox.put('default_export_quality', quality);
    notifyListeners();
  }

  void setPrompterTextOrientation(int orientation) {
    _prompterTextOrientation = orientation;
    _scheduleSettingWrite('prompter_text_orientation', orientation);
    _notifySafely();
  }

  void setPrompterSize(double width, double height) {
    _prompterWidth = width;
    _prompterHeight = height;
    _scheduleSettingWrite('prompter_width', width);
    _scheduleSettingWrite('prompter_height', height);
    _notifySafely();
  }

  void setPrompterPosition(double x, double y) {
    _prompterX = x;
    _prompterY = y;
    _scheduleSettingWrite('prompter_x', x);
    _scheduleSettingWrite('prompter_y', y);
    _notifySafely();
  }

  void _scheduleSettingWrite(String key, dynamic value) {
    _pendingSettingsWrites[key] = value;
    _settingsWriteTimer?.cancel();
    _settingsWriteTimer = Timer(const Duration(milliseconds: 220), _flushPendingSettingsWrites);
  }

  void _flushPendingSettingsWrites() {
    if (_pendingSettingsWrites.isEmpty) return;
    final entries = Map<String, dynamic>.from(_pendingSettingsWrites);
    _pendingSettingsWrites.clear();
    for (final entry in entries.entries) {
      _settingsBox.put(entry.key, entry.value);
    }
  }

  void _loadRecordingDefaults() {
    _defaultFrontCamera = _settingsBox.get(
      'default_front_camera',
      defaultValue: true,
    );
    _defaultExportQuality = _settingsBox.get(
      'default_export_quality',
      defaultValue: 'fhd',
    );
    notifyListeners();
  }

  /// Single Hive flush + one [notifyListeners] — avoids dozens of rebuilds during restore.
  void applyRestoredBackupSettings(Map<String, dynamic> settings) {
    if (settings.isEmpty) return;
    _settingsWriteTimer?.cancel();
    _flushPendingSettingsWrites();

    bool changed = false;

    void putVoice(bool v) {
      if (_voiceSyncEnabled != v) {
        _voiceSyncEnabled = v;
        changed = true;
      }
      _settingsBox.put('voice_sync_enabled', v);
    }

    void putAutoBackup(bool v) {
      if (_autoBackupEnabled != v) {
        _autoBackupEnabled = v;
        changed = true;
      }
      _settingsBox.put('auto_backup_enabled', v);
    }

    void putBackupVideos(bool v) {
      if (_backupVideosEnabled != v) {
        _backupVideosEnabled = v;
        changed = true;
      }
      _settingsBox.put('backup_videos_enabled', v);
    }

    void putWifiOnly(bool v) {
      if (_wifiOnlyBackup != v) {
        _wifiOnlyBackup = v;
        changed = true;
      }
      _settingsBox.put('wifi_only_backup', v);
    }

    void putCountdown(dynamic v) {
      final cd = switch (v) {
        num n => n.toInt(),
        _ => int.tryParse(v.toString()) ?? _countdownDuration,
      };
      if (_countdownDuration != cd) {
        _countdownDuration = cd;
        changed = true;
      }
      _settingsBox.put('countdown_duration', cd);
    }

    void putDouble(String boxKey, double current, dynamic v,
        void Function(double) assign) {
      final d = (v is num) ? v.toDouble() : double.tryParse(v.toString());
      if (d == null) return;
      if (current != d) {
        assign(d);
        changed = true;
      }
      _settingsBox.put(boxKey, d);
    }

    void putInt(String boxKey, int current, dynamic v, void Function(int) assign) {
      final i = switch (v) {
        num n => n.toInt(),
        _ => int.tryParse(v.toString()),
      };
      if (i == null) return;
      if (current != i) {
        assign(i);
        changed = true;
      }
      _settingsBox.put(boxKey, i);
    }

    void putPrompterSize(dynamic wRaw, dynamic hRaw) {
      final w = (wRaw is num) ? wRaw.toDouble() : double.tryParse(wRaw.toString());
      final h = (hRaw is num) ? hRaw.toDouble() : double.tryParse(hRaw.toString());
      if (w == null || h == null) return;
      if (_prompterWidth != w || _prompterHeight != h) {
        _prompterWidth = w;
        _prompterHeight = h;
        changed = true;
      }
      _settingsBox.put('prompter_width', w);
      _settingsBox.put('prompter_height', h);
    }

    void putPrompterPos(dynamic xRaw, dynamic yRaw) {
      final x =
          (xRaw is num) ? xRaw.toDouble() : double.tryParse(xRaw.toString());
      final y =
          (yRaw is num) ? yRaw.toDouble() : double.tryParse(yRaw.toString());
      if (x == null || y == null) return;
      if (_prompterX != x || _prompterY != y) {
        _prompterX = x;
        _prompterY = y;
        changed = true;
      }
      _settingsBox.put('prompter_x', x);
      _settingsBox.put('prompter_y', y);
    }

    if (settings.containsKey('mirrorTextEnabled')) {
      final val = settings['mirrorTextEnabled'] == true ||
          settings['mirrorTextEnabled'] == 'true';
      if (_mirrorTextEnabled != val) {
        _mirrorTextEnabled = val;
        changed = true;
      }
      _settingsBox.put('mirror_text_enabled', val);
    }
    if (settings.containsKey('voiceSyncEnabled')) {
      putVoice(settings['voiceSyncEnabled'] == true ||
          settings['voiceSyncEnabled'] == 'true');
    }
    if (settings.containsKey('autoBackupEnabled')) {
      putAutoBackup(settings['autoBackupEnabled'] == true ||
          settings['autoBackupEnabled'] == 'true');
    }
    if (settings.containsKey('backupVideosEnabled')) {
      putBackupVideos(settings['backupVideosEnabled'] == true ||
          settings['backupVideosEnabled'] == 'true');
    }
    if (settings.containsKey('wifiOnlyBackup')) {
      putWifiOnly(settings['wifiOnlyBackup'] == true ||
          settings['wifiOnlyBackup'] == 'true');
    }
    if (settings.containsKey('countdownDuration')) {
      putCountdown(settings['countdownDuration']);
    }
    if (settings.containsKey('prompterFontSize')) {
      putDouble('prompter_font_size', _prompterFontSize,
          settings['prompterFontSize'], (d) => _prompterFontSize = d);
    }
    if (settings.containsKey('prompterOpacity')) {
      putDouble('prompter_opacity', _prompterOpacity,
          settings['prompterOpacity'], (d) => _prompterOpacity = d);
    }
    if (settings.containsKey('prompterScrollSpeed')) {
      putDouble('prompter_scroll_speed', _prompterScrollSpeed,
          settings['prompterScrollSpeed'], (d) => _prompterScrollSpeed = d);
    }
    if (settings.containsKey('prompterTextOrientation')) {
      putInt(
        'prompter_text_orientation',
        _prompterTextOrientation,
        settings['prompterTextOrientation'],
        (v) => _prompterTextOrientation = v,
      );
    }
    if (settings.containsKey('prompterWidth') &&
        settings.containsKey('prompterHeight')) {
      putPrompterSize(settings['prompterWidth'], settings['prompterHeight']);
    }
    if (settings.containsKey('prompterX') &&
        settings.containsKey('prompterY')) {
      putPrompterPos(settings['prompterX'], settings['prompterY']);
    }

    if (changed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _settingsWriteTimer?.cancel();
    _flushPendingSettingsWrites();
    super.dispose();
  }
}
