import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDisplay extends StatelessWidget {
  const VideoDisplay({required this.videoController,  super.key});
  final VideoPlayerController videoController;

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
                maxHeight: MediaQuery
                    .of(context)
                    .size
                    .height * 0.6,
              ),
              child: AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: VideoPlayer(videoController),
              ),
            ),
          ),
          Card(
            child: Column(
              children: [
                VideoProgressIndicator(videoController, allowScrubbing: false),

                ListTile(title: _buildMediaControlButton(),),
              ],
            ),
          )

        ],
      );
    } else {
      return Container(
        height: size.height * 0.6,
        child: Center(
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
      },
      icon: Icon(
        videoController.value.isPlaying
            ? Icons.pause
            : Icons.play_arrow,
      ),
    );
  }
}
