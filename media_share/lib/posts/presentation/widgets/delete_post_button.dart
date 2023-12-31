import 'package:media_share/auth_feature_package/auth_feature/lib/auth_feature.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/application/providers/internet_connection.dart';
import '../../application/notifiers/posts_notifier.dart';
import '../../domain/models/post.dart';

class DeletePostButton extends ConsumerWidget {
  const DeletePostButton({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<bool> internetConnected = ref.watch(internetConnectionProvider );
    bool isUserPost = post.userId == AuthFeature.instance.repository.authUser.userId;

    return Visibility(
      visible: isUserPost,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red[100]),
        onPressed: () async{
          if (internetConnected.hasValue && internetConnected.value == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No internet connection'),
              ),
            );
            return;
          }
          await ref.read(postsNotifierProvider.notifier).deletePost(post.postId);
          context.pop();
        }, child: const Text('delete post',style: TextStyle(color: Colors.red),),),
    );
  }
}
