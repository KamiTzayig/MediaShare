import 'package:flutter/material.dart';
import '../../../../../../auth_feature_repository_base/lib/auth_failure.dart';
import '../../../core/domain/models/base_models/google_auth_state.dart';
import '../../application/state.dart';


/// {@template google_auth_body}
/// Body of the GoogleAuthPage.
///
/// Add what it does
/// {@endtemplate}
class GoogleAuthBody extends ConsumerWidget {
  /// {@macro google_auth_body}
  const GoogleAuthBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoogleAuthState googleAuthState = ref.watch(
        googleAuthStateNotifierProvider);
    final bool isLoading = googleAuthState.isLoading;
    final AuthFailure authFailure = googleAuthState.authFailure;

    return Column(

      children: [

        if (isLoading)
          const CircularProgressIndicator()
        else
          ElevatedButton(
            onPressed: () {
              ref
                  .read(googleAuthStateNotifierProvider.notifier)
                  .signInWithGoogle();
            },
            child: const Text("Sign In With Google"),
          ),
        if (authFailure.authFailureCode != AuthFailureCode.none)
          Text(authFailure.authFailureCode + " === " + authFailure.message.toString())
      ],
    );
  }
}
