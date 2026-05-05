import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Script extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  @HiveField(2)
  DateTime createdAt;
  @HiveField(3)
  String category;

  Script({
    required this.title,
    required this.content,
    required this.createdAt,
    required this.category,
  });

  int get wordCount =>
      content.trim().isEmpty ? 0 : content.trim().split(RegExp(r'\s+')).length;

  int get readTime => (wordCount / 130).ceil();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'category': category,
    };
  }

  factory Script.fromMap(Map<String, dynamic> map) {
    return Script(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      category: map['category'] ?? '',
    );
  }
}

class ScriptAdapter extends TypeAdapter<Script> {
  @override
  final int typeId = 0;

  @override
  Script read(BinaryReader reader) {
    return Script(
      title: reader.read(),
      content: reader.read(),
      createdAt: reader.read(),
      category: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Script obj) {
    writer.write(obj.title);
    writer.write(obj.content);
    writer.write(obj.createdAt);
    writer.write(obj.category);
  }
}
