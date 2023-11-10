import 'package:flutter/material.dart';
import './widgets/posts_body.dart';

/// {@template posts_page}
/// A description for PostsPage
/// {@endtemplate}
class PostsPage extends StatelessWidget {
  /// {@macro posts_page}
  const PostsPage({super.key});

  /// The static route for PostsPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const PostsPage());
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PostsView(),
    );
  }  
}

/// {@template posts_view}
/// Displays the Body of PostsView
/// {@endtemplate}
class PostsView extends StatelessWidget {
  /// {@macro posts_view}
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PostsBody();
  }
}