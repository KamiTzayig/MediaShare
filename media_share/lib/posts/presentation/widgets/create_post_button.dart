import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../application/state.dart';

class CreatePostButton extends ConsumerWidget {
  const CreatePostButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async{

        context.push('/posts/create');},
      child: Text("Add Post"),
    );
  }
}
