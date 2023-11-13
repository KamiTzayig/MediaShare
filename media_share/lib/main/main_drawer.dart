import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/material.dart';
import 'package:media_share/main/theme_list_tile.dart';


class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Media Share'),
          ),
        ThemeListTile(),
          ListTile(
            title: Text('Sign Out'),
            leading: Icon(Icons.logout),
            onTap: () {
              AuthFeature.instance.repository.signOut();
            },
          ),
        ],
      ),
    );
  }
}
