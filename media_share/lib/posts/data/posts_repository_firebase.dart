import 'package:media_share/posts/domain/models/comment.dart';

import 'package:media_share/posts/domain/models/post.dart';

import '../domain/posts_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostsRepositoryFirebase implements PostsRepository {
  final _firestore = FirebaseFirestore.instance;

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
  Future<void> createPost(Post post) async {
    await _firestore.collection('posts').add({
      'mediaUrl': post.mediaUrl,
      'description': post.description,
      'postType': post.postType,
      'userId': post.userId,
      'createdAt': FieldValue.serverTimestamp(),
    });
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
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            Map<String, dynamic> json = {...doc.data(), 'postId': doc.id};
            return Post.fromJson(json);
          }).toList());
}
