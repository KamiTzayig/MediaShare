

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/local_main_repository_hive.dart';

part 'theme_notifier.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {

  final LocalMainRepositoryHive _localMainRepositoryHive = LocalMainRepositoryHive.instance;
  @override
   ThemeMode build() {
    return _localMainRepositoryHive.getThemeMode();
  }

  void setThemeMode(ThemeMode themeMode) {
    _localMainRepositoryHive.setThemeMode(themeMode);
    state = themeMode;
  }
}
