import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_share/posts/application/providers/post_data_provider.dart';
import 'package:media_share/posts/presentation/widgets/media_display_widget.dart';
import 'package:media_share/posts/presentation/widgets/post_description.dart';

import '../application/state.dart';
import '../domain/file_type.dart';
import '../domain/models/post.dart';

class PostPage extends ConsumerWidget {
  const PostPage({required this.postId, super.key});

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Post post = ref.watch(postDataProvider(postId));
    bool isUserPost =
        post.userId == AuthFeature.instance.repository.authUser.userId;
    return Scaffold(
      appBar: AppBar(
        title: Text(post.postId),
      ),
      body: Column(
        children: [
          MediaDisplayWidget(
            fileType: post.postType == "images"
                ? FileType.image
                : FileType.video,
            url: post.mediaUrl,
          ),
         PostDescription(post: post),

          isUserPost
              ? ElevatedButton(onPressed: () async{
               await ref.read(postsNotifierProvider.notifier).deletePost(postId);
               context.pop();


          }, child: Text('delete post'))
              : const SizedBox(),
        ],
      ),
    );
  }
}
