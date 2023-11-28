import 'package:media_share/auth_feature_package/auth_feature/lib/auth_feature.dart' show AuthFeature;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_share/posts/domain/models/file_and_type.dart';
import 'package:media_share/posts/presentation/widgets/media_display_widget.dart';
import 'package:media_share/posts/presentation/widgets/post_description.dart';
import 'package:media_share/posts/presentation/widgets/upload_post_button.dart';
import '../../core/presentation/main_layout.dart';
import '../application/notifiers/pick_file_notifier.dart';
import '../domain/models/post.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  ConsumerState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  Post post = Post.unknown()
      .copyWith(userId: AuthFeature.instance.repository.authUser.userId);

  @override
  Widget build(BuildContext context) {
    FileAndType? fileAndType = ref.watch(pickFileNotifierProvider);
    Size size = MediaQuery
        .of(context)
        .size;
    return MainLayout(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            fileAndType != null
                ? MediaDisplayWidget(
              fileType: fileAndType.fileType,
              file: fileAndType.file,
              url: fileAndType.blobUrl,
            ):  _buildChooseMedia(ref, size),
            PostDescription(
                post: post,
                onEdit: (String postId, String description) async {
                  post = post.copyWith(description: description);
                }),
            UploadPostButton(
                fileAndType: fileAndType,
                post: post),
          ],
        ),
      ),
    );
  }

  Widget _buildChooseMedia(WidgetRef ref, Size size) {
    return Container(
      alignment: Alignment.center,
      color: Colors.grey[300],
      height: size.height * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAddMediaButton(onPressed:  () {
            ref
                .read(pickFileNotifierProvider.notifier)
                .pickFile();
          }, icon: Icons.perm_media_rounded),

          !kIsWeb ? _buildAddMediaButton(onPressed: () {
            ref
                .read(pickFileNotifierProvider.notifier)
                .pickFileFromCamera();
          }, icon: Icons.camera_alt_rounded) : Container(),
        ],
      ),
    );
  }

  Widget _buildAddMediaButton(
      {required void Function() onPressed, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
