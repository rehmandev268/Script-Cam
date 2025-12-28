import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/script_model.dart';

class ScriptsProvider extends ChangeNotifier {
  final Box<Script> _scriptBox;
  String _searchQuery = "";

  ScriptsProvider(this._scriptBox);

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
      final combinedText = "${script.title} ${script.content}".toLowerCase();
      return combinedText.contains(category.toLowerCase());
    }).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void addScript(String title, String content) {
    final newScript = Script(
      title: title,
      content: content,
      createdAt: DateTime.now(),
    );
    _scriptBox.add(newScript);
    notifyListeners();
  }

  void deleteScript(Script script) {
    script.delete();
    notifyListeners();
  }

  void updateScript(Script script, String newTitle, String newContent) {
    script.title = newTitle;
    script.content = newContent;
    script.save();
    notifyListeners();
  }
}
