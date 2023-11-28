
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../../auth_feature_repository_base/lib/auth_failure.dart';
import '../../../../../../auth_feature_repository_base/lib/auth_feature_repository_base.dart';
import '../../../../auth_feature.dart';
import '../../../core/auth_feature_class.dart';
import '../../../core/domain/models/base_models/google_auth_state.dart';

part 'google_auth_state_notifier.g.dart';
@riverpod
class GoogleAuthStateNotifier extends _$GoogleAuthStateNotifier {
  @override
 GoogleAuthState build() => GoogleAuthState.unknown();


  Future<void> signInWithGoogle() async{
    state = state.copyWith(isLoading: true);
    AuthFeatureRepositoryBase repository=  AuthFeature.instance.repository;

    try {
      await repository.signInWithGoogle();
      state = state.copyWith(isLoading: false);
    } on AuthFailure catch (e) {
      state = state.copyWith(authFailure: e, isLoading: false);
    }
  }

}