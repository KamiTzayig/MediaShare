import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import '../../application/state.dart';
import '../../domain/models/post.dart';

/// {@template posts_body}
/// Body of the PostsPage.
///
/// Add what it does
/// {@endtemplate}
class PostsGrid extends ConsumerWidget {
  /// {@macro posts_body}
  const PostsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Post>> posts = ref.watch(postsStreamProvider);
    return posts.when(
        data: (List<Post> posts) {
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              // return GridTile(child: Container(color: Colors.red),);
              return FancyShimmerImage(
                width: 100,
                height: 100,
                imageUrl: posts[index].mediaUrl,
              );
            },
          );
        },
        error: (_, StackTrace stackTrace) {
          print(_);
          print(stackTrace);
        return  Center(child: Text("error"));
        },
        loading: () => const CircularProgressIndicator());
  }
}
