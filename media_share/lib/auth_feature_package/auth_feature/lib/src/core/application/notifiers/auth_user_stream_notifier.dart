

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../../auth_feature_repository_base/lib/auth_failure.dart';
import '../../../../../../auth_feature_repository_base/lib/auth_feature_repository_base.dart';
import '../../../../../../auth_feature_repository_base/lib/auth_user_model.dart';
import '../../auth_feature_class.dart';


part 'auth_user_stream_notifier.g.dart';

@riverpod
class AuthUserStreamNotifier extends _$AuthUserStreamNotifier {
  final AuthFeatureRepositoryBase _repository = AuthFeature.instance.repository;

  @override
  Stream<AuthUser> build() => _repository.authUserStream;


  Future<void> signOut() async{
    AuthFeatureRepositoryBase repository =  AuthFeature.instance.repository;
    try {
      await repository.signOut();
    } on AuthFailure catch (e) {
      print(e.message);
      print(e.authFailureCode);
    }
  }
}
