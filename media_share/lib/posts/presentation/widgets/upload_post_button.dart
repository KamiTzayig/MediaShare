import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/application/providers/internet_connection.dart';
import '../../application/notifiers/posts_notifier.dart';
import '../../application/providers/upload_status_provider.dart';
import '../../domain/models/file_and_type.dart';
import '../../domain/models/post.dart';

class UploadPostButton extends ConsumerWidget {
  const UploadPostButton(
      {required this.fileAndType, required this.post, super.key});

  final FileAndType? fileAndType;
  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<double> uploadProgress = ref.watch(uploadStatusProvider);
    AsyncValue<bool> internetConnected = ref.watch(internetConnectionProvider );

    return
      uploadProgress.when(
        data: (progress) => LinearProgressIndicator(value: progress),
        error: (_, __) => Text(_.toString()),
        loading: () =>  ElevatedButton(
          onPressed: fileAndType == null
              ? () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('No media selected'),
              ),
            );

          }
              : () async {

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
                .createPost(fileAndType: fileAndType!, post: post);
            context.pop();
          },
          child: Text('upload post')
      )
      );


  }
}
