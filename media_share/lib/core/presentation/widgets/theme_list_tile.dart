import 'package:flutter/material.dart';

import '../../application/notifiers/theme_notifier.dart';
import '../../../posts/application/state.dart';

class ThemeListTile extends ConsumerWidget {
  const ThemeListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeNotifierProvider);
    return  SwitchListTile(
      title: Text('Dark Mode'),
      value: Theme.of(context).brightness == Brightness.dark,
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
