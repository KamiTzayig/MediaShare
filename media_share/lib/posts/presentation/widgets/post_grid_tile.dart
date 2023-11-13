import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/post.dart';

class PostGirdTile extends StatelessWidget {
  const PostGirdTile({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.push('/posts/${post.postId}');
        },
        child: Stack(children: [
          FancyShimmerImage(
            boxFit: BoxFit.cover,
            imageUrl: post.thumbnailUrl == '' ? post.mediaUrl : post
                .thumbnailUrl,
          ),
          post.postType == 'videos'
              ? const Positioned(
            bottom: 6,
            right: 6,
            child: Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 50,
            ),
          ):Container(),
        ],

        )

    );
  }
}
