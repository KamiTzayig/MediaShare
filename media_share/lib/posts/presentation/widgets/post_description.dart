import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../application/state.dart';
import '../../domain/models/post.dart';

class PostDescription extends HookConsumerWidget {
  const PostDescription({required this.post, super.key});
  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isUserPost =
        post.userId == AuthFeature.instance.repository.authUser.userId;
    TextEditingController _descriptionController = useTextEditingController(text: post.description);

    final inEditMode = useState(false);


    return inEditMode.value ? Row(
     
      children:[Expanded(
        child: TextField(
          controller: _descriptionController,
        ),
      ),
        IconButton(onPressed: () async{
          await ref.read(postsNotifierProvider.notifier).editPostDescription(postId: post.postId, description: _descriptionController.text);
          inEditMode.value = false;
        }, icon: Icon(Icons.save),
        ),
        IconButton(onPressed: (){
          inEditMode.value = false;
        }, icon: Icon(Icons.cancel),
        ),
      ]


    ):

      Row(
      children: [
        Text(post.description),
        isUserPost
            ? IconButton(
                onPressed: () {
            inEditMode.value = true;
                },
                icon: Icon(Icons.edit))
            : const SizedBox(),
      ],
    );
  }
}
