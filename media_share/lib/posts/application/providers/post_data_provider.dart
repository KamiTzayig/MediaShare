import 'package:media_share/posts/application/providers/posts_stream.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/post.dart';

part 'post_data_provider.g.dart';

@riverpod
class PostData extends _$PostData {

  @override
  Post build(String postId) {
    return ref.watch(postsStreamProvider).when(
        data: (posts) => posts.firstWhere((post) => post.postId == postId),
        error: (_, __) => Post.unknown(),
        loading: () => Post.unknown());
  }
}
