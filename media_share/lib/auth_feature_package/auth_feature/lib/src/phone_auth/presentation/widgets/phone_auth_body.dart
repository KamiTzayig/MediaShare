import 'package:flutter/material.dart';
import '../../../../../../auth_feature_repository_base/lib/auth_failure.dart';
import '../../../core/domain/models/base_models/phone_auth_state.dart';
import '../../application/state.dart';
import 'insert_phone_number.dart';
import 'insert_sms_code.dart';

class PhoneAuthBody extends ConsumerWidget {
  const PhoneAuthBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PhoneAuthState state = ref.watch(phoneAuthStateNotifierProvider);
    final bool smsSent = state.smsSent;
    final bool isLoading = state.isLoading;
    final AuthFailure authFailure = state.authFailure;
    return Column(
      children: [
        Text("phone auth"),
        if(isLoading) CircularProgressIndicator(),
        if(!smsSent) InsertPhoneNumber(),
        if(!smsSent) TextButton(onPressed: () => ref.read(phoneAuthStateNotifierProvider.notifier).signInWithPhoneNumber(), child: Text("send sms code")),
        if(smsSent) InsertSmsCode(),
        if(smsSent) TextButton(onPressed: () => ref.read(phoneAuthStateNotifierProvider.notifier).verifySmsCode(), child: Text("sign in with sms code")),
        if(authFailure.authFailureCode!=AuthFailureCode.none)
          ...[Text(authFailure.authFailureCode),
            Text(authFailure.message??'-')]
      ],
    );
  }
}
