import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/local_posts_repository_hive.dart';
import '../../domain/models/post.dart';

part 'posts_stream.g.dart';

@riverpod
class PostsStream extends _$PostsStream {
  final LocalPostsRepositoryHive _localRepository = LocalPostsRepositoryHive.instance;


  @override
  Stream<List<Post>> build() => _localRepository.postsLocalStream;



}

