
import 'package:flutter/material.dart';
import './widgets/posts_grid.dart';




class PostsView extends StatelessWidget {
  /// {@macro posts_view}
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: PostsGrid(),
        ),
      ],
    );
  }
}
