import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/script_model.dart';
import '../../../../core/services/analytics_service.dart';

class ScriptsProvider extends ChangeNotifier {
  final Box<Script> _scriptBox;
  String _searchQuery = "";

  ScriptsProvider(this._scriptBox);

  List<Script>? _cachedFilteredScripts;
  String? _lastSearchQuery;
  final Map<String, List<Script>> _categoryCache = {};

  bool get isSearching => _searchQuery.isNotEmpty;

  List<Script> get scripts => _scriptBox.values.toList();

  List<Script> get filteredScripts {
    if (_cachedFilteredScripts != null && _lastSearchQuery == _searchQuery) {
      return _cachedFilteredScripts!;
    }

    final all = _scriptBox.values.toList();
    _lastSearchQuery = _searchQuery;

    if (_searchQuery.isEmpty) {
      _cachedFilteredScripts = all.reversed.toList();
    } else {
      final query = _searchQuery.toLowerCase();
      _cachedFilteredScripts = all
          .where(
            (s) =>
                s.title.toLowerCase().contains(query) ||
                s.content.toLowerCase().contains(query),
          )
          .toList()
          .reversed
          .toList();
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
      result = baseList.where((script) => script.category == category).toList();
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

  void addScript(String title, String content, String category) {
    final newScript = Script(
      title: title,
      content: content,
      createdAt: DateTime.now(),
      category: category,
    );
    _scriptBox.add(newScript).then((_) {
      AnalyticsService().logScriptCreated(
        scriptId: newScript.key?.toString() ?? 'new',
        title: title,
        category: category,
        wordCount: content.split(' ').length,
      );
    });
    _cachedFilteredScripts = null;
    _categoryCache.clear();
    notifyListeners();
  }

  void deleteScript(Script script) {
    AnalyticsService().logScriptDeleted(
      scriptId: script.key?.toString() ?? 'unknown',
      category: script.category,
    );
    script.delete();
    _cachedFilteredScripts = null;
    _categoryCache.clear();
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
    _cachedFilteredScripts = null;
    _categoryCache.clear();
    notifyListeners();
  }
}
