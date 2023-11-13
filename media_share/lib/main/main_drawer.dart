import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
