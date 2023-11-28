

import '../../../../../../../auth_feature_repository_base/lib/auth_failure.dart';
import 'auth_state.dart';

class EmailAuthState extends AuthState{
  final String email;
  final String password;

  EmailAuthState({
    required this.email,
    required this.password,
    required bool isLoading,
    required AuthFailure authFailure,
  }) : super(
    isLoading: isLoading,
    authFailure: authFailure,
  );
  EmailAuthState.unknown():
        email = '',
        password = '',
        super(
          isLoading: false,
          authFailure: AuthFailure.unknown(),
        );
  @override
  EmailAuthState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    AuthFailure? authFailure,
  }) {
    return EmailAuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      authFailure: authFailure ?? this.authFailure,
    );
  }
  @override
  List<Object?> get props => [email, password, isLoading, authFailure];

}