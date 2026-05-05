import 'package:shared_preferences/shared_preferences.dart';

class RecentScriptsService {
  static const String _key = 'recent_script_keys';
  static const int _maxRecent = 3;

  static Future<void> recordUsed(dynamic scriptKey) async {
    if (scriptKey == null) return;
    final prefs = await SharedPreferences.getInstance();
    final keyStr = scriptKey.toString();
    final existing = prefs.getStringList(_key) ?? [];
    existing.remove(keyStr);
    existing.insert(0, keyStr);
    if (existing.length > _maxRecent) existing.length = _maxRecent;
    await prefs.setStringList(_key, existing);
  }

  static Future<List<String>> getRecentKeys() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }
}
