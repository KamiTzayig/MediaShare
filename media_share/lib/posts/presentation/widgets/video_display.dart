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
    Size size = MediaQuery.of(context).size;
    if (videoUrl != null) {
      return VideoDisplayFromDatabase(videoUrl: videoUrl!);
    } else if (videoFile != null) {
      return VideoDisplayFromFile(videoFile: videoFile!);
    } else {
      return Container(
        height:size.height * 0.7,
        color: Colors.grey[300],
        child: const Center(
          child: Text('Unsupported file type'),
        ),
      );
    }
  }
}
