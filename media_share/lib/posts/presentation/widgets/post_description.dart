import 'package:media_share/auth_feature_package/auth_feature/lib/auth_feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../domain/models/post.dart';

class PostDescription extends HookConsumerWidget {
  const PostDescription({required this.post,required this.onEdit, super.key});

  final Post post;
  final Future<void> Function(String postId,String description) onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isUserPost =
        post.userId == AuthFeature.instance.repository.authUser.userId;
     TextEditingController descriptionController =
        useTextEditingController(text: post.description);

    final inEditMode = useState(false);

    return inEditMode.value
        ? Card(
          child: Row(children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: descriptionController,
                    maxLines: 3,

                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await onEdit(post.postId,descriptionController.text);
                  inEditMode.value = false;
                },
                icon: const Icon(Icons.save),
              ),
              IconButton(
                onPressed: () {
                  inEditMode.value = false;
                },
                icon: const Icon(Icons.cancel),
              ),
            ]),
        )
        : Card(
          child: Row(
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Text('description: ${post.description}',softWrap: true,)),
                ),
                isUserPost
                    ? IconButton(
                        onPressed: () {
                          inEditMode.value = true;
                        },
                        icon: const Icon(Icons.edit))
                    : const SizedBox(),
              ],
            ),
        );
  }
}
