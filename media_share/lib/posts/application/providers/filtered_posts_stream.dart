import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_share/posts/application/notifiers/type_filter_notifier.dart';
import 'package:media_share/posts/domain/file_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/posts_repository_firebase.dart';
import '../../domain/models/post.dart';
import '../../domain/posts_repository.dart';

part 'filtered_posts_stream.g.dart';

@riverpod
class FilteredPostsStream extends _$FilteredPostsStream {
  final PostsRepository _repository = PostsRepositoryFirebase();


  @override
  Stream<List<Post>> build() {
    Stream<List<Post>> posts = _repository.postsStream;
    MediaType mediaType = ref.watch(typeFilterNotifierProvider);

    if (mediaType == MediaType.unknown) {
      return posts;
    } else {
      return posts.map((posts) =>
          posts.where((post) => post.postType == mediaType.pathName).toList());
    }
  }
}
