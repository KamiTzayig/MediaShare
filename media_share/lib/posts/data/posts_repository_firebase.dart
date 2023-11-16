import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:media_share/posts/domain/models/file_type.dart';
import 'package:media_share/posts/domain/models/comment.dart';

import 'package:media_share/posts/domain/models/post.dart';
import 'package:uuid/uuid.dart';

import '../domain/posts_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'local_posts_repository_hive.dart';

class PostsRepositoryFirebase implements PostsRepository {

  static final PostsRepositoryFirebase _singleton = PostsRepositoryFirebase
      ._internal();

  PostsRepositoryFirebase._internal();

  static PostsRepositoryFirebase get instance => _singleton;

  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  StreamController<double> uploadStreamController = StreamController<double>.broadcast();

 Stream<List<Post>>? _postsStream;

  Stream<double> get uploadProgressStream => uploadStreamController.stream;



  @override
  Stream<List<Post>> get postsStream {
    _postsStream ??= _firestore
          .collection('posts')
          .orderBy('createdTimestamp', descending: true)
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) => snapshot.docs
          .where(
            (doc) => !doc.metadata.hasPendingWrites,
      )
          .map((doc) {
        Map<String, dynamic> json = {...doc.data(), 'postId': doc.id};
        json['createdTimestamp'] =
            (json['createdTimestamp'] as Timestamp).millisecondsSinceEpoch;
        return Post.fromJson(json);
      }).toList());

    return _postsStream!;
    }



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
      required MediaType fileType,
      required Uint8List? thumbnailData,
        Uint8List? mediaData}) async {

    uploadStreamController.add(0.0);

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
        .child("thumb-$fileId");

    late Uint8List mediaBytes;

    if(kIsWeb && mediaData != null){
      mediaBytes = mediaData;
    }else{
      mediaBytes =  await mediaFile.readAsBytes();
  }

    try {
      final mediaUploadTask = mediaRef.putData(
        mediaBytes,
      );

      late UploadTask thumbnailUploadTask;

      if (thumbnailData != null) {
        thumbnailUploadTask = thumbnailRef.putData(
          thumbnailData,
        );
      } else {
        thumbnailUploadTask = thumbnailRef.putData(
          mediaBytes,
        );
      }



      mediaUploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final int totalBytes = mediaUploadTask.snapshot.totalBytes +
            thumbnailUploadTask.snapshot.totalBytes;

        final double progress = (snapshot.bytesTransferred.toDouble() +
            thumbnailUploadTask.snapshot.bytesTransferred.toDouble())/totalBytes;
        uploadStreamController.add(progress);
      });

      await Future.wait([mediaUploadTask, thumbnailUploadTask]);
      uploadStreamController.add(1.0);


      final mediaUrl = await mediaRef.getDownloadURL();
      final thumbnailUrl = await thumbnailRef.getDownloadURL();

      post = post.copyWith(
          mediaUrl: mediaUrl,
          thumbnailUrl: thumbnailUrl,
          postType: fileType.pathName);
      Map<String, dynamic> json = post.toJson();
      json['createdTimestamp'] = FieldValue.serverTimestamp();

      await _firestore.collection('posts').add(json);

      final localPostsRepositoryHive = LocalPostsRepositoryHive.instance;
      await localPostsRepositoryHive.putMedia(mediaUrl, mediaBytes);
      await localPostsRepositoryHive.putMedia(
          thumbnailUrl, thumbnailData ?? mediaBytes);
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      uploadStreamController.add(0.0);
    }
  }

  @override
  Future<Uint8List?> downloadMedia(String url) async {
    final ref = _storage.refFromURL(url);
    try {
      final data = await ref.getData(20974760);
      return data;
    } catch (e) {
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
  Future<void> editPostDescription(
      {required String postId, required String description}) async {
    await _firestore
        .collection('posts')
        .doc(postId)
        .update({'description': description});
  }
}
