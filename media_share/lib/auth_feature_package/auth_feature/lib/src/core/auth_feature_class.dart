
import '../../../../auth_feature_repository_base/lib/auth_feature_repository_base.dart';

class AuthFeature {
  static final AuthFeature _singleton = AuthFeature._internal();
  AuthFeature._internal();
  static AuthFeature get instance => _singleton;

  late AuthFeatureRepositoryBase _repository;

  void initialize(AuthFeatureRepositoryBase repository){
    _repository = repository;
  }

  AuthFeatureRepositoryBase get repository => _repository;
}