
import '../../../../../../../auth_feature_repository_base/lib/auth_failure.dart';
import 'auth_state.dart';

class GoogleAuthState extends AuthState {
  GoogleAuthState({
    required super.isLoading,
    required super.authFailure,
  });

  GoogleAuthState.unknown()
      : super(
          isLoading: false,
          authFailure: AuthFailure.unknown(),
        );

  @override
  GoogleAuthState copyWith({
    bool? isLoading,
    AuthFailure? authFailure,
  }) {
    return GoogleAuthState(
      isLoading: isLoading?? this.isLoading,
      authFailure: authFailure ?? this.authFailure,
    );
  }

  @override
  List<Object?> get props => [isLoading, authFailure];
}
