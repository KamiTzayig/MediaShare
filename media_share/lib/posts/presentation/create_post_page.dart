
import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_share/main/main_layout.dart';
import 'package:media_share/posts/domain/models/file_and_type.dart';
import 'package:media_share/posts/presentation/widgets/media_display_widget.dart';
import '../application/notifiers/pick_file_notifier.dart';
import '../application/state.dart';
import '../domain/models/post.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  ConsumerState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final Post post = Post.unknown()
      .copyWith(userId: AuthFeature.instance.repository.authUser.userId);


  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(postsNotifierProvider);
    FileAndType? fileAndType = ref.watch(pickFileNotifierProvider);
    return MainLayout(
     child: Column(
        children: [
          fileAndType != null
              ? MediaDisplayWidget(fileType: fileAndType.fileType, file: fileAndType.file,)
              :
          IconButton.outlined(
              onPressed: () {
                ref
                    .read(pickFileNotifierProvider.notifier)
                    .pickFile();
              },
              icon: Icon(Icons.add)),
          Spacer(),
          isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
            onPressed: fileAndType == null
                ? () {}
                : () async {
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
