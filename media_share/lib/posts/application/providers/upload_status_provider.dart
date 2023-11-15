import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_share/posts/data/posts_repository_firebase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upload_status_provider.g.dart';

@riverpod
class UploadStatus extends _$UploadStatus {
  final PostsRepositoryFirebase _repository = PostsRepositoryFirebase.instance;

  @override
  Stream<double> build() {
    return _repository.uploadStreamController.stream;
  }
}
