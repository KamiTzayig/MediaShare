import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_share/posts/application/providers/post_data_provider.dart';

import '../application/state.dart';
import '../domain/models/post.dart';

class PostPage extends ConsumerWidget {
  const PostPage({required this.postId,super.key});
  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Post post = ref.watch(postDataProvider(postId));

    return Scaffold(
      appBar: AppBar(
        title: Text(post.postId),
      ),
      body: Center(
        child: Text(post.description),
      ),
    );
  }
}
