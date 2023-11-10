import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_share/core/extentions/to_file.dart';
import 'package:media_share/posts/domain/file_type.dart';
import 'dart:io';

import '../../application/state.dart';

class CreatePostButton extends ConsumerWidget {
  const CreatePostButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async{
        final File? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery).toFile();
        if (imageFile == null) {
          return;
        }
        context.go('/posts/create',extra: {'file': imageFile,'fileType': FileType.image});},
      child: Text("Add Post"),
    );
  }
}
