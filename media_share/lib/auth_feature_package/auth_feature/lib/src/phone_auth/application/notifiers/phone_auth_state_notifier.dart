import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../../auth_feature_repository_base/lib/auth_failure.dart';
import '../../../../../../auth_feature_repository_base/lib/auth_feature_repository_base.dart';
import '../../../../auth_feature.dart';
import '../../../core/auth_feature_class.dart';
import '../../../core/domain/models/base_models/phone_auth_state.dart';

part 'phone_auth_state_notifier.g.dart';

@riverpod
class PhoneAuthStateNotifier extends _$PhoneAuthStateNotifier {
  @override
  PhoneAuthState build() {
    AuthFeatureRepositoryBase repository = AuthFeature.instance.repository;

    StreamSubscription<bool> smsSentStream =
        repository.smsSentStream.listen((smsSent) {
      state = state.copyWith(smsSent: smsSent);
    });

    ref.onDispose(() {
      smsSentStream.cancel();
    });


        return PhoneAuthState.unknown();

  }

  void setPhoneNumber(String phoneNumber) {
    state = state.copyWith(phoneNumber: phoneNumber);
  }

  void setSmsCode(String smsCode) {
    state = state.copyWith(smsCode: smsCode);
  }

  Future<void> signInWithPhoneNumber() async {
    state = state.copyWith(isLoading: true);
    AuthFeatureRepositoryBase repository = AuthFeature.instance.repository;
    try {
      await repository.signInWithPhoneNumber(phoneNumber: state.phoneNumber);
      state = state.copyWith(isLoading: false);
    } on AuthFailure catch (e) {
      state = state.copyWith(authFailure: e, isLoading: false);
    }
  }

  Future<void> verifySmsCode() async {
    state = state.copyWith(isLoading: true);
    AuthFeatureRepositoryBase repository = AuthFeature.instance.repository;
    try {
      await repository.verifySmsCode(smsCode: state.smsCode);
      state = state.copyWith(isLoading: false);
    } on AuthFailure catch (e) {
      state = state.copyWith(authFailure: e, isLoading: false);
    }
  }
}
