import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_share/posts/application/notifiers/type_filter_notifier.dart';
import 'package:media_share/posts/domain/models/file_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/local_posts_repository_hive.dart';
import '../../domain/models/post.dart';

part 'filtered_posts_stream.g.dart';

@riverpod
class FilteredPostsStream extends _$FilteredPostsStream {
  final LocalPostsRepositoryHive _localRepository = LocalPostsRepositoryHive.instance;

  @override
  Stream<List<Post>> build() {
    MediaType mediaType = ref.watch(typeFilterNotifierProvider);
    Stream<List<Post>> posts = _localRepository.postsLocalStream;

   if (mediaType == MediaType.unknown) {
      return posts;
    } else {
      return posts.map((posts) => posts.where((post) {
            return post.postType == mediaType.pathName;
          }).toList());
    }
  }
}
