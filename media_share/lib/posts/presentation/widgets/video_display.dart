import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_share/posts/presentation/widgets/video_display_from_database.dart';
import 'package:media_share/posts/presentation/widgets/video_display_from_file.dart';
import 'dart:io';

class VideoDisplay extends StatelessWidget {
  const VideoDisplay({
    this.videoFile,
    this.videoUrl,
    Key? key,
  }) : super(key: key);

  final String? videoUrl;
  final File? videoFile;

  @override
  Widget build(BuildContext context) {
    if (videoFile != null) {
      return VideoDisplayFromFile(videoFile: videoFile!);
    } else if (videoUrl != null) {
      return VideoDisplayFromDatabase(videoUrl: videoUrl!);
    } else {
      return Center(
        child: Text('Unsupported file type'),
      );
    }
  }
}
