//example of an abstract repository which the data layer will implement
import 'dart:typed_data';

import 'file_type.dart';
import 'models/comment.dart';
import 'models/post.dart';
import 'dart:io' show File;

abstract class PostsRepository {
  Stream<List<Post>> get postsStream;
  Future<void> createPost({required Post post,required File mediaFile,required MediaType fileType, required Uint8List? thumbnailData});
  Future<void> editPostDescription({required String postId,required String description});
  Future<void> deletePost(String postId);
  Future<void> createComment(Comment comment);
  Future<void> deleteComment(String commentId);
  Future<Uint8List?> downloadMedia(String url);



}
