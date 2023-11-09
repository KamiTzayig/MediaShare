import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          children: [
            ElevatedButton(
              onPressed: () {
                AuthFeature.instance.repository.signOut();
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
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
