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
      _videoController.setLooping(true);

    }
  }


  @override
  void dispose() {
    if (widget.fileAndType.fileType == FileType.video ) {
      _videoController.dispose();
    }
    super.dispose();
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
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              child: AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              setState(() {
                if (_videoController.value.isPlaying) {
                  _videoController.pause();
                } else {
                  _videoController.play();
                }
              });
            },
            icon: Icon(
              _videoController.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
          ),
        ],
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

}
