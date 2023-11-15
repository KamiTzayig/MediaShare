import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoDisplayFromBlob extends StatefulWidget {
  const VideoDisplayFromBlob({
    required this.blobUrl,
    super.key,
  });

  final String blobUrl;


  @override
  State<VideoDisplayFromBlob> createState() => _VideoDisplayFromBlobState();
}

class _VideoDisplayFromBlobState extends State<VideoDisplayFromBlob> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
      _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.blobUrl))
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
        setState(() {});
      },
      icon: Icon(
        _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
      ),
    );
  }
}
