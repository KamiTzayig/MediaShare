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
      child: post.postType == 'videos'
          ? Container(
              color: Colors.blue,
            )
          : FancyShimmerImage(
              boxFit: BoxFit.cover,
              imageUrl: post.mediaUrl,
            ),
    );
  }
}
