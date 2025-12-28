import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  final Box _settingsBox;

  ThemeProvider(this._settingsBox) {
    _loadTheme();
  }

  void _loadTheme() {
    final savedMode = _settingsBox.get('theme_mode', defaultValue: 0);
    if (savedMode == 1) {
      _themeMode = ThemeMode.light;
    } else if (savedMode == 2)
    {
      _themeMode = ThemeMode.dark;
    }
    else{
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    int saveVal = 0;
    if (mode == ThemeMode.light) saveVal = 1;
    if (mode == ThemeMode.dark) saveVal = 2;
    _settingsBox.put('theme_mode', saveVal);
    notifyListeners();
  }
}
