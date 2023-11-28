import 'package:flutter/material.dart';
import './widgets/google_auth_body.dart';

/// {@template google_auth_page}
/// A description for GoogleAuthPage
/// {@endtemplate}
class GoogleAuthPage extends StatelessWidget {
  /// {@macro google_auth_page}
  const GoogleAuthPage({super.key});

  /// The static route for GoogleAuthPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const GoogleAuthPage());
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleAuthView(),
    );
  }  
}

/// {@template google_auth_view}
/// Displays the Body of GoogleAuthView
/// {@endtemplate}
class GoogleAuthView extends StatelessWidget {
  /// {@macro google_auth_view}
  const GoogleAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return const GoogleAuthBody();
  }
}
