import 'package:equatable/equatable.dart';

import 'comment.dart';

/// {@template post}
/// Post description
/// {@endtemplate}
class Post extends Equatable {
  /// {@macro post}
  const Post({ 
    required this.postId,
    required this.description,
    required this.postType,
    required this.mediaUrl,
    required this.thumbnailUrl,
    required this.userId,
    required this.createdTimestamp,
    required this.comments,
    required this.likes,
  });

  
        /// initial constructor for Post
    Post.unknown():
        postId = '',
        description = '',
        postType = '',
        mediaUrl = '',
        thumbnailUrl = '',
        userId = '',
        createdTimestamp = 0,
        comments = [],
        likes = [];
    


    /// Creates a Post from Json map
  factory Post.fromJson(Map<String, dynamic> json) => Post(
        postId: json['postId'] as String,
        description: json['description'] as String,
        postType: json['postType'] as String,
        mediaUrl: json['mediaUrl'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String,
        userId: json['userId'] as String,
        createdTimestamp: json['createdTimestamp'] as int,
        comments: (json['comments'] as List<dynamic>).map((dynamic e) => Comment.fromJson(e as Map<String, dynamic>)).toList(),
        likes: json['likes'] as List<String>,
      );

  /// A description for postId
  final String postId;

  /// A description for description
  final String description;

  /// A description for postType
  final String postType;

  /// A description for mediaUrl
  final String mediaUrl;

  /// A description for thumbnailUrl
  final String thumbnailUrl;

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
    String? description,
    String? postType,
    String? mediaUrl,
    String? thumbnailUrl,
    String? userId,
    int? createdTimestamp,
    List<Comment>? comments,
    List<String>? likes,
  }) {
    return Post(
      postId: postId ?? this.postId,
      description: description ?? this.description,
      postType: postType ?? this.postType,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      userId: userId ?? this.userId,
      createdTimestamp: createdTimestamp ?? this.createdTimestamp,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
    );
  }


    @override
  List<Object?> get props => [
        postId,
        description,
        postType,
        mediaUrl,
        thumbnailUrl,
        userId,
        createdTimestamp,
        comments,
        likes,
      ];

    /// Creates a Json map from a Post
  Map<String, dynamic> toJson() => <String, dynamic>{ 
        'postId': postId,
        'description': description,
        'postType': postType,
        'mediaUrl': mediaUrl,
        'thumbnailUrl': thumbnailUrl,
        'userId': userId,
        'createdTimestamp': createdTimestamp,
        'comments': comments,
        'likes': likes,
      };
}
