import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/script_model.dart';
import '../../../../core/services/analytics_service.dart';

class ScriptsProvider extends ChangeNotifier {
  final Box<Script> _scriptBox;
  String _searchQuery = "";
  List<Script>? _allScriptsCache;

  ScriptsProvider(this._scriptBox);

  List<Script>? _cachedFilteredScripts;
  String? _lastSearchQuery;
  final Map<String, List<Script>> _categoryCache = {};

  bool get isSearching => _searchQuery.isNotEmpty;

  List<Script> get scripts {
    final cached = _allScriptsCache;
    if (cached != null) return cached;
    final computed = _scriptBox.values.toList(growable: false);
    _allScriptsCache = computed;
    return computed;
  }

  void _invalidateCaches() {
    _allScriptsCache = null;
    _cachedFilteredScripts = null;
    _categoryCache.clear();
  }

  List<Script> get filteredScripts {
    if (_cachedFilteredScripts != null && _lastSearchQuery == _searchQuery) {
      return _cachedFilteredScripts!;
    }

    final all = scripts;
    _lastSearchQuery = _searchQuery;

    if (_searchQuery.isEmpty) {
      _cachedFilteredScripts = all.reversed.toList(growable: false);
    } else {
      final query = _searchQuery.toLowerCase();
      _cachedFilteredScripts = all
          .where(
            (s) =>
                s.title.toLowerCase().contains(query) ||
                s.content.toLowerCase().contains(query),
          )
          .toList(growable: false)
          .reversed
          .toList(growable: false);
    }
    return _cachedFilteredScripts!;
  }

  List<Script> getScriptsByCategory(String category) {
    if (_categoryCache.containsKey(category)) {
      return _categoryCache[category]!;
    }

    final baseList = filteredScripts;
    List<Script> result;

    if (category == "All") {
      result = baseList;
    } else {
      result = baseList
          .where((script) => script.category == category)
          .toList(growable: false);
    }

    _categoryCache[category] = result;
    return result;
  }

  void setSearchQuery(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    _cachedFilteredScripts = null;
    _categoryCache.clear();
    if (query.isNotEmpty) {
      AnalyticsService().logSearchPerformed(
        searchTerm: query,
        resultsCount: filteredScripts.length,
      );
    }
    notifyListeners();
  }

  static int _wordCountForAnalytics(String content) {
    final t = content.trim();
    if (t.isEmpty) return 0;
    return t.split(RegExp(r'\s+')).length;
  }

  /// Persists a new script and returns the same [Script] instance (Hive key set after add).
  Future<Script> addScriptAndReturn(
    String title,
    String content,
    String category,
  ) async {
    final newScript = Script(
      title: title,
      content: content,
      createdAt: DateTime.now(),
      category: category,
    );
    await _scriptBox.add(newScript);
    AnalyticsService().logScriptCreated(
      scriptId: newScript.key?.toString() ?? 'new',
      title: title,
      category: category,
      wordCount: _wordCountForAnalytics(content),
    );
    _invalidateCaches();
    notifyListeners();
    return newScript;
  }

  void addScript(String title, String content, String category) {
    unawaited(addScriptAndReturn(title, content, category));
  }

  /// One notification after all rows — used by cloud restore.
  Future<void> importScriptsFromRestore(List<Script> restored) async {
    if (restored.isEmpty) return;
    for (final script in restored) {
      await _scriptBox.add(script);
      AnalyticsService().logScriptCreated(
        scriptId: script.key?.toString() ?? 'new',
        title: script.title,
        category: script.category,
        wordCount: _wordCountForAnalytics(script.content),
      );
    }
    _invalidateCaches();
    notifyListeners();
  }

  void deleteScript(Script script) {
    AnalyticsService().logScriptDeleted(
      scriptId: script.key?.toString() ?? 'unknown',
      category: script.category,
    );
    script.delete();
    _invalidateCaches();
    notifyListeners();
  }

  void updateScript(
    Script script,
    String newTitle,
    String newContent,
    String newCategory,
  ) {
    script.title = newTitle;
    script.content = newContent;
    script.category = newCategory;
    script.save();
    AnalyticsService().logScriptEdited(
      scriptId: script.key?.toString() ?? 'unknown',
      title: newTitle,
      category: newCategory,
      wordCount: newContent.split(' ').length,
    );
    _invalidateCaches();
    notifyListeners();
  }
}
