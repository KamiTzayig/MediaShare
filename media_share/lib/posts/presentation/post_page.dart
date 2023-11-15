import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_share/posts/application/providers/post_data_provider.dart';
import 'package:media_share/posts/presentation/widgets/delete_post_button.dart';
import 'package:media_share/posts/presentation/widgets/media_display_widget.dart';
import 'package:media_share/posts/presentation/widgets/post_description.dart';

import '../../core/application/providers/internet_connection.dart';
import '../../core/presentation/main/main_layout.dart';
import '../application/state.dart';
import '../domain/file_type.dart';
import '../domain/models/post.dart';

class PostPage extends ConsumerWidget {
  const PostPage({required this.postId, super.key});

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Post post = ref.watch(postDataProvider(postId));
    AsyncValue<bool> internetConnected = ref.watch(internetConnectionProvider );

    return MainLayout(
     child: SingleChildScrollView(
       child: Column(
          children: [
            MediaDisplayWidget(
              fileType: post.postType == "videos"
                  ? MediaType.video
                  : MediaType.image,
              url: post.mediaUrl,
            ),
           PostDescription(post: post, onEdit: (String postId, String description) async {
              if (internetConnected.hasValue && internetConnected.value == false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No internet connection'),
                  ),
                );
                return;
              }
             await ref
                 .read(postsNotifierProvider.notifier)
                 .editPostDescription( postId: postId,description:  description);
           }),

            DeletePostButton(
              post: post,
            ),
          ],
        ),
     ),
    );
  }
}
