import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_share/core/application/providers/internet_connection.dart';


import '../../application/state.dart';

class CreatePostButton extends ConsumerWidget {
  const CreatePostButton({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<bool> internetConnected = ref.watch(internetConnectionProvider );
    return FloatingActionButton(
      onPressed: () {
      if (internetConnected.hasValue && internetConnected.value == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No internet connection'),
            ),
          );
          return;
        }
        context.push('/posts/create');
      },
      child: const Icon(Icons.add),
    );
  }
}
