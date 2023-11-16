import 'dart:io';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../application/providers/media_local_cache_provider.dart';
import '../../application/state.dart';

class ImageDisplay extends ConsumerWidget {
  const ImageDisplay({this.imageFile, this.imageUrl, super.key});

  final String? imageUrl;
  final File? imageFile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    bool isFile = imageUrl == null;

   late AsyncValue<Uint8List?> imageData;
    if (!isFile && imageUrl != '' && !kIsWeb ) {
      imageData = ref.watch(mediaLocalCacheProvider(imageUrl!));
    }

    return isFile
        ? _buildImageFile(imageFile!, size)
        :  kIsWeb?
        _buildImageWeb(imageUrl!, size)

        :

    imageUrl != ''
            ? imageData.when(
                data: (data) => _buildImageMemory(data, size),
                loading: () => Container(
                  color: Colors.grey[300],
                  height: size.height * 0.7,
                ),
                error: (error, stack) => FancyShimmerImage(
                  boxFit: BoxFit.cover,
                  color: Colors.red,
                  imageUrl: '',
                ),
              )
            : SizedBox(
                height: size.height * 0.7,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
  }

  Widget _buildImageFile(File imageFile, Size size) {
    return Image.file(
      imageFile,
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool wasSynchronouslyLoaded) {
        return frame == null
            ? SizedBox(
                height: size.height * 0.7,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SizedBox(
                height: size.height * 0.7,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: child,
                ),
              );
      },
    );
  }

  Widget _buildImageMemory(Uint8List? imageData, Size size) {
    return imageData == null
        ? Container(
            height: size.height * 0.7,
            color: Colors.grey[300],
          )
        : Image.memory(
            imageData,
            frameBuilder: (BuildContext context, Widget child, int? frame,
                bool wasSynchronouslyLoaded) {
              return frame == null
                  ? SizedBox(
                      height: size.height * 0.7,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox(
                      height: size.height * 0.7,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: child,
                      ),
                    );
            },
          );
  }

  Widget _buildImageWeb(String blobUrl, Size size) {
    return Image.network(
      blobUrl,
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool wasSynchronouslyLoaded) {
        return frame == null
            ? SizedBox(
          height: size.height * 0.7,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        )
            : SizedBox(
          height: size.height * 0.7,
          child: FittedBox(
            fit: BoxFit.cover,
            child: child,
          ),
        );
      },
    );
  }

  }
