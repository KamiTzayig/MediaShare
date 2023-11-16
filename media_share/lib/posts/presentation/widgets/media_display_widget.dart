
import 'package:flutter/cupertino.dart';
import 'package:media_share/posts/presentation/widgets/video_display.dart';
import 'dart:io';
import '../../domain/models/file_type.dart';
import 'package:flutter/material.dart';

import 'image_display.dart';

class MediaDisplayWidget extends StatelessWidget {
  final String? url;
  final File? file;
  final MediaType fileType;


  MediaDisplayWidget({required this.fileType, this.file, this.url, });




  @override
  Widget build(BuildContext context) {
    if (fileType == MediaType.video) {
      return VideoDisplay(videoFile: file, videoUrl: url);
    } else if (fileType == MediaType.image) {
      return ImageDisplay(imageFile: file, imageUrl: url);
    } else {
      return Center(
        child: Text('Unsupported file type'),
      );
    }
  }
}
