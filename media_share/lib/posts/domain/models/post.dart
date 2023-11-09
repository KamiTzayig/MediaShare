import 'package:equatable/equatable.dart';

import 'comment.dart';

/// {@template post}
/// Post description
/// {@endtemplate}
class Post extends Equatable {
  /// {@macro post}
  const Post({ 
    required this.postId,
    required this.title,
    required this.body,
    required this.userId,
    required this.createdTimestamp,
    required this.comments,
    required this.likes,
  });

  
        /// initial constructor for Post
    Post.unknown():
        postId = '',
        title = '',
        body = '',
        userId = '',
        createdTimestamp = 0,
        comments = [],
        likes = [];
    


    /// Creates a Post from Json map
  factory Post.fromJson(Map<String, dynamic> json) => Post(
        postId: json['postId'] as String,
        title: json['title'] as String,
        body: json['body'] as String,
        userId: json['userId'] as String,
        createdTimestamp: json['createdTimestamp'] as int,
        comments: (json['comments'] as List<dynamic>).map((dynamic e) => Comment.fromJson(e as Map<String, dynamic>)).toList(),
        likes: json['likes'] as List<String>,
      );

  /// A description for postId
  final String postId;

  /// A description for title
  final String title;

  /// A description for body
  final String body;

  /// A description for userId
  final String userId;

  /// A description for createdTimestamp
  final int createdTimestamp;

  /// A description for comments
  final List<Comment> comments;

  /// A description for likes
  final List<String> likes;

    /// Creates a copy of the current Post with property changes
  Post copyWith({ 
    String? postId,
    String? title,
    String? body,
    String? userId,
    int? createdTimestamp,
    List<Comment>? comments,
    List<String>? likes,
  }) {
    return Post(
      postId: postId ?? this.postId,
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
      createdTimestamp: createdTimestamp ?? this.createdTimestamp,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
    );
  }


    @override
  List<Object?> get props => [
        postId,
        title,
        body,
        userId,
        createdTimestamp,
        comments,
        likes,
      ];

    /// Creates a Json map from a Post
  Map<String, dynamic> toJson() => <String, dynamic>{ 
        'postId': postId,
        'title': title,
        'body': body,
        'userId': userId,
        'createdTimestamp': createdTimestamp,
        'comments': comments,
        'likes': likes,
      };
}
