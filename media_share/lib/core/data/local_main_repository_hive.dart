import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class LocalMainRepositoryHive {
  //singleton
  static final LocalMainRepositoryHive _singleton =
      LocalMainRepositoryHive._internal();

  LocalMainRepositoryHive._internal();

  static LocalMainRepositoryHive get instance => _singleton;

  late Box<Map> _settingsBox;

  Future<void> init() async {
    _settingsBox = await Hive.openBox<Map>('settings');
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _settingsBox.put('themeMode', {'mode': themeMode.index});
  }

  ThemeMode getThemeMode() {
    return ThemeMode.values[_settingsBox.get('themeMode',
        defaultValue: {'mode': ThemeMode.system})?['mode'] as int];
  }
}
