import 'package:flutter/cupertino.dart';
import 'package:media_share/posts/domain/models/file_and_type.dart';
import 'dart:io';
import '../../domain/file_type.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MediaDisplayWidget extends StatefulWidget {

  final String? url;
  final File? file;
  final FileType fileType;

  MediaDisplayWidget({ required this.fileType, this.file, this.url });

  @override
  _MediaDisplayWidgetState createState() => _MediaDisplayWidgetState();
}

class _MediaDisplayWidgetState extends State<MediaDisplayWidget> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.fileType == FileType.video && widget.file != null ) {
      _videoController = VideoPlayerController.file(widget.file!)
        ..initialize().then((_) {
          setState(() {});
        });
      _videoController.setLooping(true);
    } else if (widget.fileType == FileType.video  && widget.url != null) {
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
    if (widget.fileType == FileType.video ) {
      _videoController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.fileType == FileType.video) {
      return _buildVideoPlayer();
    } else if (widget.fileType == FileType.image) {
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
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              ),
            ),
          ),
          Card(
            child: Column(
              children: [
                VideoProgressIndicator(_videoController, allowScrubbing: false),

                ListTile(title: _buildMediaControlButton() ,),
              ],
            ),
          )

        ],
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildImage() {
    return widget.file != null? Image.file(widget.file!) : Image.network(widget.url!) ;
  }

  Widget _buildMediaControlButton (){
    return IconButton(
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
    );
  }

}
