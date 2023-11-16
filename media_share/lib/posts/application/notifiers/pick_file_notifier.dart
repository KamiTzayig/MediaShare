import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:media_share/core/domain/extentions/to_file.dart';
import 'package:media_share/posts/domain/models/file_and_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/file_type.dart';

part 'pick_file_notifier.g.dart';

@riverpod
class PickFileNotifier extends _$PickFileNotifier {
  @override
  FileAndType? build() {
    return null;
  }


// pick file using FileType

  Future<void> _processFile(XFile? xFile) async {
    String fileName = xFile?.name ?? '';
    File? file = xFile.toFile();

    String? blobUrl = file?.path;
    if (file?.path.substring(0, 4) != 'blob') {
      blobUrl = null;
    }
    MediaType? fileType;

    switch (fileName
        .split('.')
        .last) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        fileType = MediaType.image;
        break;
      case 'mp4':
      case 'mov':
        fileType = MediaType.video;
        break;
      default:
        fileType = null;
    }

    FileAndType? fileAndType =
    file != null && fileType != null ? FileAndType(
        file: file, fileType: fileType, blobUrl: blobUrl) : null;
    state = fileAndType;
  }

  Future<void> pickFile() async {
    final ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickMedia();
    await _processFile(xFile);
  }


  Future<void> pickFileFromCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickImage(source: ImageSource.camera);
    await _processFile(xFile);
  }
}
