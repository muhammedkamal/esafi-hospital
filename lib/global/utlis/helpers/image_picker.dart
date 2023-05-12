import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<File> pickImage(
      {ImageSource imageSource = ImageSource.camera}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);
    return File(pickedFile!.path);
  }
}
