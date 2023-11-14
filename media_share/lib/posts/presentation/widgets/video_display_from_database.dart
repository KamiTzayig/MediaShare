import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../application/providers/media_local_cache_provider.dart';
import '../../application/state.dart';
import 'video_display_from_file.dart';

class VideoDisplayFromDatabase extends ConsumerWidget {
  const VideoDisplayFromDatabase({required this.videoUrl, super.key});

  final String videoUrl;

  Future<File?> _writeBytesToFile(Uint8List data) async {
    Directory tempDir = Directory.systemTemp;
    File file = File('${tempDir.path}/test.mp4');

    await file.writeAsBytes(data);
    await file.exists();
    if (!await file.exists()) {
      print('file does not exist');
      return null;
    }
    return file;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Uint8List?> imageData =
        ref.watch(mediaLocalCacheProvider(videoUrl));
    Size size = MediaQuery.of(context).size;
    return imageData.when(
      data: (data) {
        if (data != null) {
          return FutureBuilder(
            future: _writeBytesToFile(data),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return VideoDisplayFromFile(videoFile: snapshot.data as File);
              } else {
                return Container(
                  height: size.height * 0.7,
                  color: Colors.grey[300],
                );
              }
            },
          );
        } else {
          return Container(
            height: size.height * 0.7,
            color: Colors.grey[300],
          );
        }
      },
      error: (_, __) => Container(
        height: 600,
        color: Colors.red,
      ),
      loading: () => Container(
        height: size.height * 0.6,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
