import 'dart:io';

import 'package:image_picker/image_picker.dart';

extension ToFile on Future<XFile?> {
  Future<File?> toFile() => then((xFile) => xFile?.path)
      .then((filePath) => filePath != null ? File(filePath) : null);
}

extension ToFileSync on XFile? {
  File? toFile() => this?.path != null ? File(this!.path) : null;
}