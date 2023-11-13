import 'package:flutter/material.dart';

import '../core/notifiers/theme_notifier.dart';
import '../posts/application/state.dart';

class ThemeListTile extends ConsumerWidget {
  const ThemeListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return  SwitchListTile(
      title: Text('Dark Mode'),
      value: ref.watch(themeNotifierProvider) == ThemeMode.dark,
      onChanged: (bool value) {
        if (value) {
          ref.read(themeNotifierProvider.notifier).setThemeMode(ThemeMode.dark);
        } else {
          ref.read(themeNotifierProvider.notifier).setThemeMode(ThemeMode.light);
        }
      },
    );
  }
}
