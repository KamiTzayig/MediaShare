import 'package:flutter/material.dart';
import 'package:media_share/core/presentation/widgets/theme_list_tile.dart';

import '../../../auth_feature_package/auth_feature/lib/auth_feature.dart';


class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Media Share'),
          ),
        const ThemeListTile(),

          ListTile(
            title: const Text('Sign Out'),
            leading: const Icon(Icons.logout),
            onTap: () {
              AuthFeature.instance.repository.signOut();
            },
          ),
        ],
      ),
    );
  }
}
