import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../phone_auth/application/state.dart';
import 'package:flutter/material.dart';

class InsertPhoneNumber extends HookConsumerWidget {
  const InsertPhoneNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    return TextField(
      controller: textEditingController,
      decoration: const InputDecoration(
        hintText: 'Insert Phone Number',
      ),
      onChanged: (value) {
        ref.read(phoneAuthStateNotifierProvider.notifier).setPhoneNumber(value);
      },
    );
  }
}

