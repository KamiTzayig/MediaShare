import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/local_posts_repository_hive.dart';
import '../../domain/models/post.dart';

part 'post_data_provider.g.dart';

@riverpod
class PostData extends _$PostData {

  final LocalPostsRepositoryHive _localRepository = LocalPostsRepositoryHive.instance;

  @override
  Post build(String postId) {
   return _localRepository.getPost(postId);

  }
}
