import 'package:auth_feature/auth_feature.dart' show EmailAuthBody;
import 'package:flutter/foundation.dart' show  ValueNotifier;
import 'package:go_router/go_router.dart';
import 'package:media_share/posts/presentation/create_post_page.dart' show CreatePostPage;
import 'package:media_share/posts/presentation/post_page.dart' show PostPage;

import 'core/presentation/main_layout.dart' show MainLayout;
import 'core/presentation/main_page.dart' show MainPage;

final ValueNotifier<RoutingConfig> myRoutingConfig =
    ValueNotifier<RoutingConfig>(loggedOutRoutingConfig);
final GoRouter router = GoRouter.routingConfig(routingConfig: myRoutingConfig);

final RoutingConfig loggedInRoutingConfig = RoutingConfig(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) => const MainPage(),
    ),
    GoRoute(
      path: '/posts/create',
      builder: (_, GoRouterState state) {
        return const CreatePostPage();},
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
      builder: (_, __) => const MainLayout(
        child: EmailAuthBody(),
      ),
    ),
  ],
);
