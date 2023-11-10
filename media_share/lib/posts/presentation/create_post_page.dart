import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../application/state.dart';
import '../domain/file_type.dart';
import '../domain/models/post.dart';

class CreatePostPage extends ConsumerWidget {
  final File file;
  final FileType fileType;

  CreatePostPage({
    super.key,
    required this.file,
    required this.fileType,
  });

  final Post post = Post.unknown()
      .copyWith(userId: AuthFeature.instance.repository.authUser.userId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(postsNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      body: Column(
        children: [
          Image.file(file),
          isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    ref
                        .read(postsNotifierProvider.notifier)
                        .createPost(file: file, fileType: fileType, post: post);
                  },
                  child: Text("Create Post"),
                ),
        ],
      ),
    );
  }
}
