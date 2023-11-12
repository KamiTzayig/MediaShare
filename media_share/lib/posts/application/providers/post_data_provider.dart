import 'package:media_share/posts/application/providers/posts_stream.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/post.dart';

part 'post_data_provider.g.dart';

@riverpod
class PostData extends _$PostData {
  @override
  Post build(String postId) {
    AsyncValue<List<Post>> postsAsync = ref.watch(postsStreamProvider);
    Post p = postsAsync.when(data: (posts) {
      return posts.firstWhere((Post post) => post.postId == postId);
    }, loading: () {
      return Post.unknown();
    }, error: (error, stackTrace) {
      return Post.unknown();
    }
    );

    return p;
  }
}
