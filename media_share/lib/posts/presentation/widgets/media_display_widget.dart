import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../../domain/file_type.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'image_display.dart';
import 'video_display.dart';

class MediaDisplayWidget extends StatefulWidget {

  final String? url;
  final File? file;
  final MediaType fileType;

  MediaDisplayWidget({ required this.fileType, this.file, this.url });

  @override
  _MediaDisplayWidgetState createState() => _MediaDisplayWidgetState();
}

class _MediaDisplayWidgetState extends State<MediaDisplayWidget> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.fileType == MediaType.video && widget.file != null) {
      _videoController = VideoPlayerController.file(widget.file!)
        ..initialize().then((_) {
          setState(() {});
        });
      _videoController.setLooping(true);
    } else if (widget.fileType == MediaType.video && widget.url != null) {
      Uri uri = Uri.parse(widget.url!);
      _videoController = VideoPlayerController.networkUrl(uri)
        ..initialize().then((_) {
          setState(() {});
        });
      _videoController.setLooping(true);
    }
  }


  @override
  void dispose() {
    if (widget.fileType == MediaType.video) {
      _videoController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.fileType == MediaType.video) {

      return VideoDisplay(videoController: _videoController);
    } else if (widget.fileType == MediaType.image) {
      return ImageDisplay(imageFile: widget.file, imageUrl: widget.url);
    } else {
      return Center(
        child: Text('Unsupported file type'),
      );
    }
  }


}
