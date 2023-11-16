import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDisplayBase extends StatelessWidget {
  const VideoDisplayBase({required this.videoController, required this.setState, super.key});

  final VideoPlayerController videoController;
  final void Function(Function()) setState;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (videoController.value.isInitialized) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              child: AspectRatio(
                aspectRatio:videoController.value.aspectRatio,
                child: VideoPlayer(videoController),
              ),
            ),
          ),
          Card(
            child: Column(
              children: [
                VideoProgressIndicator(videoController,
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
      return SizedBox(
        height: size.height * 0.7,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  Widget _buildMediaControlButton() {
    return IconButton(
      onPressed: () {
        if (videoController.value.isPlaying) {
          videoController.pause();
        } else {
          videoController.play();
        }
        setState((){});
      },
      icon: Icon(
        videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
      ),
    );
  }
}

