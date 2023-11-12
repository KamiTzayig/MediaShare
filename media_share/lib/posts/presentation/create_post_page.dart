import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_share/posts/domain/models/file_and_type.dart';
import 'package:media_share/posts/presentation/widgets/file_display_widget.dart';
import 'dart:io';
import '../application/notifiers/pick_file_notifier.dart';
import '../application/state.dart';
import '../domain/file_type.dart';
import '../domain/models/post.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  ConsumerState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final Post post = Post.unknown()
      .copyWith(userId: AuthFeature.instance.repository.authUser.userId);

  FileType? fileType;
  File? file;

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(postsNotifierProvider);
    FileAndType? fileAndType = ref.watch(pickFileNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      body: Column(
        children: [
          Expanded(
            child: fileAndType != null
                ? FileDisplayWidget(fileAndType: fileAndType)
                : Row(children: [
                    IconButton.outlined(
                        onPressed: () {
                          ref.read(pickFileNotifierProvider.notifier).pickFile(
                              fileType: FileType.image,
                              imageSource: ImageSource.gallery);
                        },
                        icon: Icon(Icons.image)),
                    IconButton.outlined(
                        onPressed: () {
                          ref.read(pickFileNotifierProvider.notifier).pickFile(
                              fileType: FileType.video,
                              imageSource: ImageSource.gallery);
                        },
                        icon: Icon(Icons.video_collection))
                  ]),
          ),
          isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: fileAndType == null
                      ? () {}
                      : () async{
                          await ref
                              .read(postsNotifierProvider.notifier)
                              .createPost(fileAndType: fileAndType, post: post);
                          context.pop();
                        },
                  child: Text("Create Post"),
                ),
        ],
      ),
    );
  }
}
