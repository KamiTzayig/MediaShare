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

  const MediaDisplayWidget({super.key,
    required this.fileType,
    this.file,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (fileType == MediaType.video) {
      return VideoDisplay(videoFile: file, videoUrl: url);
    } else if (fileType == MediaType.image) {
      return ImageDisplay(imageFile: file, imageUrl: url);
    } else {
      return SizedBox(
        height: size.height * 0.7,
        child: const Center(
          child: Text('Unsupported file type'),
        ),
      );
    }
  }
}
