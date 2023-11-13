import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../posts/presentation/posts_page.dart';
import '../posts/presentation/widgets/create_post_button.dart';
import 'main_layout.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      isMainPage: true,
      child: PostsView(),
      floatingActionButton: CreatePostButton(),
    );
  }
}
