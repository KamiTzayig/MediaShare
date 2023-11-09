import 'package:flutter/material.dart';
import '../../application/state.dart';


/// {@template posts_body}
/// Body of the PostsPage.
///
/// Add what it does
/// {@endtemplate}
class PostsBody extends ConsumerWidget {
  /// {@macro posts_body}
  const PostsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(postsStateProvider);
    return Text(count.toString());
  }
}
