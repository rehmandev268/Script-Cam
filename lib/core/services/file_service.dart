import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  static Future<Map<String, String>?> importScript() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt', 'md', 'rtf'],
    );

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      String content = await file.readAsString();
      String rawName = result.files.single.name;
      String title = rawName.contains('.')
          ? rawName.substring(0, rawName.lastIndexOf('.'))
          : rawName;
      return {'title': title, 'content': content};
    }
    return null;
  }

  static Future<void> exportScript(
    String title,
    String content, {
    required String shareSubject,
  }) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$title.txt');
    await file.writeAsString(content);

    await Share.shareXFiles([XFile(file.path)], subject: shareSubject);
  }
}
