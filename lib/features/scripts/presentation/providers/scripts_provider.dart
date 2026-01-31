import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/script_model.dart';
import '../../../../core/services/analytics_service.dart';

class ScriptsProvider extends ChangeNotifier {
  final Box<Script> _scriptBox;
  String _searchQuery = "";

  ScriptsProvider(this._scriptBox);

  bool get isSearching => _searchQuery.isNotEmpty;

  List<Script> get scripts => _scriptBox.values.toList();

  List<Script> get filteredScripts {
    final all = _scriptBox.values.toList();

    if (_searchQuery.isEmpty) {
      return all.reversed.toList();
    }

    return all
        .where(
          (s) =>
              s.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              s.content.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList()
        .reversed
        .toList();
  }

  List<Script> getScriptsByCategory(String category) {
    final baseList = filteredScripts;

    if (category == "All") {
      return baseList;
    }

    return baseList.where((script) {
      return script.category == category;
    }).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
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
    notifyListeners();
  }

  void deleteScript(Script script) {
    AnalyticsService().logScriptDeleted(
      scriptId: script.key?.toString() ?? 'unknown',
      category: script.category,
    );
    script.delete();
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
    notifyListeners();
  }
}
