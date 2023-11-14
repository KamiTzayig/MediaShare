import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    Size size = MediaQuery.of(context).size;
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
                aspectRatio:_videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              ),
            ),
          ),
          Card(
            child: Column(
              children: [
                VideoProgressIndicator(_videoController,
                    allowScrubbing: false),
                ListTile(
                  title: _buildMediaControlButton(),
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return Container(
        height: size.height * 0.7,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  Widget _buildMediaControlButton() {
    return IconButton(
      onPressed: () {
        if (_videoController.value.isPlaying) {
          _videoController.pause();
        } else {
          _videoController.play();
        }
      },
      icon: Icon(
        _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
      ),
    );
  }
}
