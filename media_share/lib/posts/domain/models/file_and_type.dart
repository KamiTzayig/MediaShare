// file and file type class
import 'dart:io';

import 'file_type.dart';
class FileAndType {
  final File file;
  final MediaType fileType;

  final String? blobUrl;

  FileAndType({required this.file, required this.fileType, this.blobUrl });



}