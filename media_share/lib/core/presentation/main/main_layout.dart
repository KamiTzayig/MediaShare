import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_share/core/presentation/widgets/no_connection.dart';

import '../../../posts/application/state.dart';
import '../../application/providers/internet_connection.dart';
import '../widgets/main_drawer.dart';

class MainLayout extends ConsumerWidget {
  const MainLayout(
      {required this.child,
      this.isMainPage = false,
      this.floatingActionButton,
      super.key});

  final Widget child;
  final bool isMainPage;

  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<bool> internetConnection = ref.watch(internetConnectionProvider);

    return SafeArea(
      child: Scaffold(
            appBar: AppBar(
              title: Text("Media Share"),
            ),
            drawer: isMainPage ? MainDrawer() : null,
            body: Stack(
              children: [
                child,
                Positioned(
                  top: 0,
                  child: internetConnection.when(
                    data: (bool active) {
                      return active
                          ? const SizedBox()
                          : NoConnection();
                    },
                    error: (_, __) => NoConnection(),
                    loading: () => NoConnection(),
                  ),)
              ],
            ),
            floatingActionButton: floatingActionButton,
          ),
    );
  }

}
