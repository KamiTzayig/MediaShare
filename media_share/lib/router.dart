import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_share/posts/presentation/create_post_page.dart';
import 'package:media_share/posts/presentation/post_page.dart';

import 'core/presentation/main_layout.dart';
import 'core/presentation/main_page.dart';

final ValueNotifier<RoutingConfig> myRoutingConfig =
    ValueNotifier<RoutingConfig>(loggedOutRoutingConfig);
final GoRouter router = GoRouter.routingConfig(routingConfig: myRoutingConfig);

final RoutingConfig loggedInRoutingConfig = RoutingConfig(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) => MainPage(),
    ),
    GoRoute(
      path: '/posts/create',
      builder: (_, GoRouterState state) {
        return CreatePostPage();},
    ),
    GoRoute(
      path: '/posts/:postId',
      builder: (_, GoRouterState state) {
        return PostPage(postId: state.pathParameters["postId"] as String);},
    ),
  ],
);

final RoutingConfig loggedOutRoutingConfig = RoutingConfig(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) => MainLayout(
        child: EmailAuthBody(),
      ),
    ),
  ],
);
