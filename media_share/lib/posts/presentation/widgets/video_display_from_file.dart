import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_share/posts/presentation/widgets/video_display_base.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';


class VideoDisplayFromFile extends StatefulWidget {
  const VideoDisplayFromFile({
    required this.videoFile,
    super.key,
  });

  final File videoFile;


  @override
  State<VideoDisplayFromFile> createState() => _VideoDisplayFromFileState();
}

class _VideoDisplayFromFileState extends State<VideoDisplayFromFile> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
      _videoController = VideoPlayerController.file(widget.videoFile)
        ..initialize().then((_) {
          setState(() {});
        });
  }

  @override
  void dispose() {
    _videoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoDisplayBase(videoController: _videoController, setState: setState);
  }
}
