
import 'package:flutter/material.dart';
import '../../../../../../auth_feature_repository_base/lib/auth_failure.dart';
// import '../../../../../../auth_feature_repository_base/lib/auth_user_model.dart';
// import '../../../core/application/notifiers/auth_user_stream_notifier.dart';
import '../../../core/domain/models/base_models/email_auth_state.dart';
import '../../application/state.dart';

class EmailAuthBody extends ConsumerWidget {
  /// {@macro email_auth_body}
  const EmailAuthBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final EmailAuthState emailAuthState =
        ref.watch(emailAuthStateNotifierProvider);
    final bool isLoading = emailAuthState.isLoading;
    // final AsyncValue<AuthUser> user = ref.watch(authUserStreamNotifierProvider);
    final AuthFailure authFailure = emailAuthState.authFailure;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value) {
                ref
                    .read(emailAuthStateNotifierProvider.notifier)
                    .setEmail(value);
              },
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              onChanged: (String value) {
                ref
                    .read(emailAuthStateNotifierProvider.notifier)
                    .setPassword(value);
              },
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(emailAuthStateNotifierProvider.notifier)
                              .signInWithEmailAndPassword();
                        },
                        child: Text('Sign In'),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(emailAuthStateNotifierProvider.notifier)
                              .signUpWithEmailAndPassword();
                        },
                        child: Text('Create an Account'),
                      ),
                    ],
                  ),
            if (authFailure.authFailureCode != AuthFailureCode.none) ...[
              Text(authFailure.authFailureCode),
              Text(authFailure.message ?? '-')
            ]
          ],
        ),
      ),
    );


  }
}
