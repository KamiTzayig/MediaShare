import 'package:media_share/auth_feature_package/auth_feature/lib/auth_feature.dart' show AuthFeature, AuthUser;
import 'package:media_share/auth_feature_package/firebase_auth_feature_repository/lib/firebase_auth_feature_repository.dart'
    show FirebaseAuthFeatureRepository;
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart' show Hive, HiveX;
import 'package:hooks_riverpod/hooks_riverpod.dart' show ProviderScope, ConsumerWidget, WidgetRef;
import 'package:media_share/posts/data/local_posts_repository_hive.dart' show LocalPostsRepositoryHive;
import 'package:media_share/router.dart';

import 'core/application/notifiers/theme_notifier.dart';
import 'core/data/local_main_repository_hive.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await LocalMainRepositoryHive.instance.init();
  await FirebaseAuthFeatureRepository.instance
      .initialize(DefaultFirebaseOptions.currentPlatform);

  AuthFeature.instance.initialize(
    FirebaseAuthFeatureRepository.instance,
  );


  runApp(const ProviderScope(
    child: MyApp(),
  ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthFeature.instance.repository.authUserStream.listen((AuthUser user) {
      if (user.userId != '') {
        if (!LocalPostsRepositoryHive.instance.isInitialized) {
          LocalPostsRepositoryHive.instance.init();
        }
        myRoutingConfig.value = loggedInRoutingConfig;
      } else {
        myRoutingConfig.value = loggedOutRoutingConfig;
      }
    });

    ThemeMode themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      title: 'Media Share',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
