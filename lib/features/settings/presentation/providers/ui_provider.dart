import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UIProvider extends ChangeNotifier {
  final Box _settingsBox;
  bool _showOnboarding = true;
  bool get showOnboarding => _showOnboarding;
  bool _showcaseSeen = false;
  bool get showcaseSeen => _showcaseSeen;

  UIProvider(this._settingsBox) {
    _checkOnboarding();
    _checkShowcase();
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

  void completeOnboarding() {
    _settingsBox.put('onboarding_seen', true);
    _showOnboarding = false;
    notifyListeners();
  }

  void completeShowcase() {
    _settingsBox.put('showcase_seen', true);
    _showcaseSeen = true;
    notifyListeners();
  }
}
