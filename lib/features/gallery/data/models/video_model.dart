import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class VideoRecord extends HiveObject {
  @HiveField(0)
  String path;
  @HiveField(1)
  DateTime date;
  VideoRecord({required this.path, required this.date});
}

class VideoAdapter extends TypeAdapter<VideoRecord> {
  @override
  final int typeId = 1;
  @override
  VideoRecord read(BinaryReader reader) =>
      VideoRecord(path: reader.read(), date: reader.read());
  @override
  void write(BinaryWriter writer, VideoRecord obj) {
    writer.write(obj.path);
    writer.write(obj.date);
  }
}
