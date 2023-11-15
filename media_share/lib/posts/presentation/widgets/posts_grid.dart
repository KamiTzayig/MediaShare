import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:media_share/posts/application/providers/filtered_posts_stream.dart';
import 'package:media_share/posts/presentation/widgets/post_grid_tile.dart';
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
    final AsyncValue<List<Post>> posts = ref.watch(filteredPostsStreamProvider);
    return posts.when(
        data: (List<Post> posts) {
          return MasonryGridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              // return GridTile(child: Container(color: Colors.red),);
              return PostGirdTile(post: posts[index]);
            },
          );
        },
        error: (_, StackTrace stackTrace) {
          print(_);
          print(stackTrace);
        return  Center(child: Text("error"),);
        },
        loading: () => const Center( child: CircularProgressIndicator(),),);
  }
}
