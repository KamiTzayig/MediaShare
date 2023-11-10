import 'dart:io';

import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/material.dart';
import 'package:media_share/posts/domain/file_type.dart';
import '../application/notifiers/posts_notifier.dart';
import '../domain/models/post.dart';
import './widgets/posts_grid.dart';

/// {@template posts_page}
/// A description for PostsPage
/// {@endtemplate}
class PostsPage extends StatelessWidget {
  /// {@macro posts_page}
  const PostsPage({super.key});

  /// The static route for PostsPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const PostsPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PostsView(),
    );
  }
}

/// {@template posts_view}
/// Displays the Body of PostsView
/// {@endtemplate}
class PostsView extends StatelessWidget {
  /// {@macro posts_view}
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer(
          builder: (context, ref, child) => ElevatedButton(
              onPressed: () {
                ref.read(postsNotifierProvider.notifier).createPost(
                      Post.unknown().copyWith(userId: "a",description: "aa",),
                      File(''),
                      FileType.image,
                    );
              },
              child: Text("Add Post")),
        ),
        PostsGrid(),
      ],
    );
  }
}
