import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_share/posts/domain/file_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/posts_repository_firebase.dart';
import '../../domain/models/comment.dart';
import '../../domain/models/post.dart';
import '../../domain/posts_repository.dart';

part 'posts_notifier.g.dart';

@riverpod
class PostsNotifier extends _$PostsNotifier {
  final PostsRepository _repository = PostsRepositoryFirebase();

  @override
  bool build() => false;

  set isLoading(bool value) => state = value;
  //create new post
  Future<void> createPost(Post post, File file, FileType fileType ) async {
    isLoading = true;
    try {
    post = post.copyWith(mediaUrl:"https://images3.alphacoders.com/165/thumb-1920-165265.jpg");
      await _repository.createPost(post);
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> deletePost(String postId) async {
    isLoading = true;
    try {
      await _repository.deletePost(postId);
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> createComment(Comment comment) async {
    isLoading = true;
    try {
      await _repository.createComment(comment);
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteComment(String commentId) async {
    isLoading = true;
    try {
      await _repository.deleteComment(commentId);
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }





}
