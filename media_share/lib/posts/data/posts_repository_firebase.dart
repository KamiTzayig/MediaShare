import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:media_share/posts/domain/file_type.dart';
import 'package:media_share/posts/domain/models/comment.dart';

import 'package:media_share/posts/domain/models/post.dart';
import 'package:uuid/uuid.dart';

import '../domain/posts_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'local_posts_repository_hive.dart';

class PostsRepositoryFirebase implements PostsRepository {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;


  @override
  Future<void> createComment(Comment comment) async {
    await _firestore.collection('comments').add({
      'comment': comment.body,
      'userId': comment.userId,
      'createdAt': FieldValue.serverTimestamp(),
      'postId': comment.postId,
    });
  }

  @override
  Future<void> createPost(
      {required Post post,
      required File mediaFile,
      required MediaType fileType, required Uint8List? thumbnailData}) async {

    final fileId = const Uuid().v4();
    final mediaRef = _storage
        .ref()
        .child(post.userId)
        .child(fileType.pathName)
        .child(fileId);
    final thumbnailRef = _storage
        .ref()
        .child(post.userId)
        .child('thumbnails')
        .child("thumb-" + fileId);

    final Uint8List mediaData = await mediaFile.readAsBytes();


    final mediaUploadTask = await mediaRef.putData(
      mediaData,
    );

    if(thumbnailData != null){
      final thumbnailUploadTask = await thumbnailRef.putData(
        thumbnailData,
      );
    }
    else{
      final thumbnailUploadTask = await thumbnailRef.putData(
        mediaData,
      );
    }


    try {

      final mediaUrl = await mediaRef.getDownloadURL();
      final thumbnailUrl = await thumbnailRef.getDownloadURL();

      post = post.copyWith(mediaUrl: mediaUrl,thumbnailUrl: thumbnailUrl, postType: fileType.pathName);
      Map<String, dynamic> json = post.toJson();
      json['createdTimestamp'] = FieldValue.serverTimestamp();

      await _firestore.collection('posts').add(json);

      final _localPostsRepositoryHive = LocalPostsRepositoryHive.instance;
      await _localPostsRepositoryHive.putMedia(mediaUrl, mediaData);
      await _localPostsRepositoryHive.putMedia(thumbnailUrl, thumbnailData??mediaData);


    } catch (e) {

      print(e);
      throw e;
    }
  }


  @override
  Future<Uint8List?> downloadMedia(String url) async{
    final ref = _storage.refFromURL(url);
    try{
      final data = await ref.getData(20974760);
      return data;
    }
    catch(e) {
      return null;
    }

  }

  @override
  Future<void> deleteComment(String commentId) async {
    await _firestore.collection('comments').doc(commentId).delete();
  }

  @override
  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }

  @override
  Stream<List<Post>> get postsStream => _firestore
      .collection('posts')
      .orderBy('createdTimestamp', descending: true)
      .snapshots(includeMetadataChanges: true)
      .map((snapshot) => snapshot.docs
              .where(
            (doc) => !doc.metadata.hasPendingWrites,
          )
              .map((doc) {
            Map<String, dynamic> json = {...doc.data(), 'postId': doc.id};
            json['createdTimestamp'] = (json['createdTimestamp'] as Timestamp).millisecondsSinceEpoch;
            return Post.fromJson(json);
          }).toList());

  @override
  Future<void> editPostDescription(
      {required String postId, required String description}) async {
    await _firestore
        .collection('posts')
        .doc(postId)
        .update({'description': description});
  }


}
