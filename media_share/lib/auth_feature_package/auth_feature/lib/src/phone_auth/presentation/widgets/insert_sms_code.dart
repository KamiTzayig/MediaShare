import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../email_auth/application/state.dart';
import '../../../phone_auth/application/notifiers/phone_auth_state_notifier.dart';
import 'package:flutter/material.dart';

class InsertSmsCode extends HookConsumerWidget {
  const InsertSmsCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();

    return TextField(
      controller: textEditingController,
      decoration: const InputDecoration(
        hintText: 'Insert Sms Code',
      ),
      onChanged: (value) {
        ref.read(phoneAuthStateNotifierProvider.notifier).setSmsCode(value);
      },
    );
  }
}
