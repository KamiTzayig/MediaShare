import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:media_share/posts/presentation/widgets/video_display_from_blob.dart';
import 'dart:io';
import '../../application/providers/media_local_cache_provider.dart';
import '../../application/state.dart';
import 'video_display_from_file.dart';
import 'package:universal_html/html.dart' as html;

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

  Future<String> _writeBytesToBlob(Uint8List bytes) async {
    // Create a Blob from the Uint8List
    var blob = html.Blob([bytes], 'video/mp4');

    // Create a Blob URL from the Blob
    var blobUrl = html.Url.createObjectUrlFromBlob(blob);

    return blobUrl;
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late AsyncValue<Uint8List?> imageData =
        ref.watch(mediaLocalCacheProvider(videoUrl));

    Size size = MediaQuery.of(context).size;
    return  imageData.when(
            data: (data) {
              if (data != null) {
                return FutureBuilder(
                  future:kIsWeb?_writeBytesToBlob(data): _writeBytesToFile(data),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return kIsWeb?VideoDisplayFromBlob(blobUrl: snapshot.data as String) :VideoDisplayFromFile(
                        videoFile: snapshot.data as File,
                      );
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
