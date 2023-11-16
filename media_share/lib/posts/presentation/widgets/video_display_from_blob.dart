import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_share/posts/presentation/widgets/video_display_base.dart';
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

    return VideoDisplayBase(videoController: _videoController, setState: setState);
  }
}
