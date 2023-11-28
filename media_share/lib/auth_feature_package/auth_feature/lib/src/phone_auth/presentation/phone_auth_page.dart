import 'package:flutter/material.dart';
import './widgets/phone_auth_body.dart';

/// {@template phone_auth_page}
/// A description for PhoneAuthPage
/// {@endtemplate}
class PhoneAuthPage extends StatelessWidget {
  /// {@macro phone_auth_page}
  const PhoneAuthPage({super.key});

  /// The static route for PhoneAuthPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const PhoneAuthPage());
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PhoneAuthView(),
    );
  }  
}

/// {@template phone_auth_view}
/// Displays the Body of PhoneAuthView
/// {@endtemplate}
class PhoneAuthView extends StatelessWidget {
  /// {@macro phone_auth_view}
  const PhoneAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PhoneAuthBody();
  }
}
