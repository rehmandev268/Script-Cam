import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Script extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  @HiveField(2)
  DateTime createdAt;
  Script({required this.title, required this.content, required this.createdAt});
}

class ScriptAdapter extends TypeAdapter<Script> {
  @override
  final int typeId = 0;
  @override
  Script read(BinaryReader reader) => Script(
        title: reader.read(),
        content: reader.read(),
        createdAt: reader.read(),
      );
  @override
  void write(BinaryWriter writer, Script obj) {
    writer.write(obj.title);
    writer.write(obj.content);
    writer.write(obj.createdAt);
  }
}
