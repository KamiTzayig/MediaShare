import 'dart:typed_data';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../application/state.dart';
import 'package:media_share/posts/application/providers/media_local_cache_provider.dart';
import '../../domain/models/post.dart';

class PostGirdTile extends ConsumerWidget {
  const PostGirdTile({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Uint8List?> thumbnailData =
        ref.watch(mediaLocalCacheProvider(post.thumbnailUrl));

    return InkWell(
        onTap: () {
          context.push('/posts/${post.postId}');
        },
        child: Stack(
          children: [

            thumbnailData.when(
              data: (data) =>
                  data == null ? Container() :
                  Image.memory(
                data,
                fit: BoxFit.cover,
              ),
              loading: () =>  Container(color: Colors.grey[300],),
              error: (error, stack) => FancyShimmerImage(
                boxFit: BoxFit.cover,
                color: Colors.red,
                imageUrl: '',
              ),
            ),
            // FancyShimmerImage(
            //   boxFit: BoxFit.cover,
            //   imageUrl:
            //       post.thumbnailUrl == '' ? post.mediaUrl : post.thumbnailUrl,
            // ),
            post.postType == 'videos'
                ? const Positioned(
                    bottom: 6,
                    right: 6,
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                : Container(),
          ],
        ));
  }
}
