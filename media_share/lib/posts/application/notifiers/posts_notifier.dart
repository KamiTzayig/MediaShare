
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_share/posts/domain/models/file_and_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
import '../../data/posts_repository_firebase.dart';
import '../../domain/models/file_type.dart';
import '../../domain/models/comment.dart';
import '../../domain/models/post.dart';
import '../../domain/posts_repository.dart';
import 'package:http/http.dart' as http;

part 'posts_notifier.g.dart';

@riverpod
class PostsNotifier extends _$PostsNotifier {
  final PostsRepository _repository = PostsRepositoryFirebase.instance;

  @override
  bool build() => false;

  set isLoading(bool value) => state = value;
  //create new post
  Future<void> createPost({required Post post, required FileAndType fileAndType} ) async {
    isLoading = true;
    try {
      final mediaFile = fileAndType.file;
      final fileType = fileAndType.fileType;
      Uint8List? thumbnailData;
      Uint8List? mediaData;
      if (kIsWeb) {
        final String? blobPath = fileAndType.blobUrl;
        if (blobPath != null) {
          final uri = Uri.parse(blobPath);
          final client = http.Client();
          final request = await client.get(uri);
          mediaData = request.bodyBytes;
        }
      }
      if(fileType == MediaType.video) {

        thumbnailData = await VideoThumbnail.thumbnailData(
          video:  mediaFile.path,
        );
      }


      await _repository.createPost(post: post, fileType: fileType, mediaFile: mediaFile, thumbnailData: thumbnailData, mediaData: mediaData);
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> editPostDescription({required String postId, required String description}) async {
    isLoading = true;
    try {
      await _repository.editPostDescription(postId: postId, description: description);
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

