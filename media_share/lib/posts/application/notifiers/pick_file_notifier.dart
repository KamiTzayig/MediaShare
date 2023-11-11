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
  Future<void> pickFile(
      {required FileType fileType, required ImageSource imageSource}) async {
    final ImagePicker picker = ImagePicker();
    File? file;
   switch (fileType) {
      case FileType.image:

        file = await picker
            .pickImage(
          source: imageSource,
        )
            .toFile();
          break;

      case FileType.video:
        file = await picker
            .pickVideo(
          source: imageSource,
        )
            .toFile();
          break;

    }



    FileAndType? fileAndType =
        file != null ? FileAndType(file: file, fileType: fileType) : null;
    state = fileAndType;
  }
}
