import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class VideoRecord extends HiveObject {
  @HiveField(0)
  String path;
  @HiveField(1)
  DateTime date;
  VideoRecord({required this.path, required this.date});

  Map<String, dynamic> toMap() {
    return {'path': path, 'date': date.toIso8601String()};
  }

  factory VideoRecord.fromMap(Map<String, dynamic> map) {
    return VideoRecord(
      path: map['path'] ?? '',
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
    );
  }
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
