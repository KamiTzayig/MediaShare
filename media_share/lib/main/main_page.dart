import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../posts/presentation/posts_page.dart';
import '../posts/presentation/widgets/create_post_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Share'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Media Share'),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pushNamed('/profile');
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              leading: Icon(Icons.logout),
              onTap: () {
                AuthFeature.instance.repository.signOut();
              },
            ),
          ],
        ),
      ),
      body: PostsView(),
        floatingActionButton: CreatePostButton(),
    );
  }
}
