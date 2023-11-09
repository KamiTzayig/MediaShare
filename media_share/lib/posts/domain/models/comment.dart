import 'package:equatable/equatable.dart';

/// {@template comment}
/// Comment description
/// {@endtemplate}
class Comment extends Equatable {
  /// {@macro comment}
  const Comment({ 
    required this.postId,
    required this.commentId,
    required this.body,
    required this.userId,
    required this.createdTimestamp,
  });

  
        /// initial constructor for Comment
    Comment.unknown():
        postId = '',
        commentId = '',
        body = '',
        userId = '',
        createdTimestamp = 0;
    


    /// Creates a Comment from Json map
  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        postId: json['postId'] as String,
        commentId: json['commentId'] as String,
        body: json['body'] as String,
        userId: json['userId'] as String,
        createdTimestamp: json['createdTimestamp'] as int,
      );

  /// A description for postId
  final String postId;

  /// A description for commentId
  final String commentId;

  /// A description for body
  final String body;

  /// A description for userId
  final String userId;

  /// A description for createdTimestamp
  final int createdTimestamp;

    /// Creates a copy of the current Comment with property changes
  Comment copyWith({ 
    String? postId,
    String? commentId,
    String? body,
    String? userId,
    int? createdTimestamp,
  }) {
    return Comment(
      postId: postId ?? this.postId,
      commentId: commentId ?? this.commentId,
      body: body ?? this.body,
      userId: userId ?? this.userId,
      createdTimestamp: createdTimestamp ?? this.createdTimestamp,
    );
  }


    @override
  List<Object?> get props => [
        postId,
        commentId,
        body,
        userId,
        createdTimestamp,
      ];

    /// Creates a Json map from a Comment
  Map<String, dynamic> toJson() => <String, dynamic>{ 
        'postId': postId,
        'commentId': commentId,
        'body': body,
        'userId': userId,
        'createdTimestamp': createdTimestamp,
      };
}
