import 'package:flutter/cupertino.dart';
import 'package:media_share/posts/domain/models/file_and_type.dart';

import '../../domain/file_type.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FileDisplayWidget extends StatefulWidget {

  final FileAndType fileAndType;

  FileDisplayWidget({required this.fileAndType});

  @override
  _FileDisplayWidgetState createState() => _FileDisplayWidgetState();
}

class _FileDisplayWidgetState extends State<FileDisplayWidget> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.fileAndType.fileType == FileType.video) {
      _videoController = VideoPlayerController.file(widget.fileAndType.file)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fileAndType.fileType == FileType.video) {
      return _buildVideoPlayer();
    } else if (widget.fileAndType.fileType == FileType.image) {
      return _buildImage();
    } else {
      return Center(
        child: Text('Unsupported file type'),
      );
    }
  }

  Widget _buildVideoPlayer() {
    if (_videoController.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _videoController.value.aspectRatio,
        child: VideoPlayer(_videoController),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildImage() {
    return Image.file(widget.fileAndType.file);
  }

  @override
  void dispose() {
    if (widget.fileAndType.fileType == 'video') {
      _videoController.dispose();
    }
    super.dispose();
  }
}
