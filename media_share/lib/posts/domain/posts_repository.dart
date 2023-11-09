//example of an abstract repository which the data layer will implement
import 'models/comment.dart';
import 'models/post.dart';

abstract class PostsRepository {
  Stream<List<Post>> get postsStream;
  Future<void> createPost(Post post);
  Future<void> deletePost(String postId);
  Future<void> createComment(Comment comment);
  Future<void> deleteComment(String commentId);
}
