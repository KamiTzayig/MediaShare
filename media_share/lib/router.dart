import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_share/posts/domain/file_type.dart';
import 'package:media_share/posts/posts.dart';
import 'package:media_share/posts/presentation/create_post_page.dart';
import 'dart:io';

final ValueNotifier<RoutingConfig> myRoutingConfig =
    ValueNotifier<RoutingConfig>(loggedOutRoutingConfig);
final GoRouter router = GoRouter.routingConfig(routingConfig: myRoutingConfig);

final RoutingConfig loggedInRoutingConfig = RoutingConfig(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) => Scaffold(
        backgroundColor: Colors.tealAccent,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                AuthFeature.instance.repository.signOut();
              },
              child: Text('Sign Out'),
            ),
            
            Expanded(child: PostsView())
          ],
        ),
      ),
    ),
    GoRoute(
      path: '/posts/create',
      builder: (_, GoRouterState goRouterState) {
        Map<String, dynamic> extra = goRouterState.extra! as Map<String, dynamic>;
        return CreatePostPage(
        file: extra['file'] as File,
        fileType: extra['fileType'] as FileType,
      );},
    ),
  ],
);

final RoutingConfig loggedOutRoutingConfig = RoutingConfig(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) => Scaffold(
        body: EmailAuthBody(),
      ),
    ),
  ],
);
