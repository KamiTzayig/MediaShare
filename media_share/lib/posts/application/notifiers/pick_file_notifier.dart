import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:media_share/core/extentions/to_file.dart';
import 'package:media_share/posts/domain/models/file_and_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/file_type.dart';

part 'pick_file_notifier.g.dart';

@riverpod
class PickFileNotifier extends _$PickFileNotifier {
  @override
  FileAndType? build() {
    return null;
  }

// pick file using FileType
  Future<void> pickFile() async {
    final ImagePicker picker = ImagePicker();
    File? file = await picker.pickMedia().toFile();
    FileType? fileType;

    switch (file?.path.split('.').last) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        fileType = FileType.image;
        break;
      case 'mp4':
      case 'mov':
        fileType = FileType.video;
        break;
      default:
        fileType = null;
    }

    print("fileType: $fileType");

    FileAndType? fileAndType =
        file != null && fileType != null ? FileAndType(file: file, fileType: fileType) : null;
    state = fileAndType;
  }
}
