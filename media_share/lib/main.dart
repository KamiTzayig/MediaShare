import 'package:auth_feature/auth_feature.dart' ;
import 'package:firebase_auth_feature_repository/firebase_auth_feature_repository.dart';
import 'package:flutter/material.dart';
import 'package:media_share/router.dart';

import 'core/notifiers/theme_notifier.dart';
import 'firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseAuthFeatureRepository.instance
      .initialize(DefaultFirebaseOptions.currentPlatform);

  AuthFeature.instance.initialize(
    FirebaseAuthFeatureRepository.instance,
  );

  runApp( const ProviderScope(
    child: MyApp(),
  ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    AuthFeature.instance.repository.authUserStream.listen((AuthUser user) {
      if(user.userId != ''){
          myRoutingConfig.value = loggedInRoutingConfig;
      }else{
          myRoutingConfig.value = loggedOutRoutingConfig;
      }
    });

    ThemeMode themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      title: 'Media Share',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,brightness: Brightness.dark),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
