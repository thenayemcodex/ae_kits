import 'dart:developer';

import 'package:file_picker/file_picker.dart';

class MyFilePicker {
  static Future<PlatformFile?> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      print(file.path);
      return file;
    } else {
      log("User canceled the picker");
      return null;
    }
  }
}
