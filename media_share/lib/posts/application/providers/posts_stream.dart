import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/posts_repository_firebase.dart';
import '../../domain/models/post.dart';
import '../../domain/posts_repository.dart';

part 'posts_stream.g.dart';

@riverpod
class PostsStream extends _$PostsStream {
  final PostsRepository _repository = PostsRepositoryFirebase();

  @override
  Stream<List<Post>> build() => _repository.postsStream;



}

