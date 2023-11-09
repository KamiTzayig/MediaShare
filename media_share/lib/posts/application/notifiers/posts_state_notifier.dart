import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/posts_repository_implementation.dart';
import '../../domain/posts_repository.dart';


class PostsStateNotifier extends StateNotifier<bool> {
  PostsStateNotifier() : super(false);
  final PostsRepository _repository = PostsRepositoryImplementation();

  Future<void> getPing(String url) async{
    bool result = await _repository.ping(url:url);
    state = result;

}

}
