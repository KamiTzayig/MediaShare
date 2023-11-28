

import '../../../../../../../auth_feature_repository_base/lib/auth_failure.dart';
import 'auth_state.dart';


 class PhoneAuthState extends AuthState {
  final String phoneNumber;
  final String smsCode;

  final bool smsSent;

  PhoneAuthState({
    required this.phoneNumber,
    required this.smsCode,
    required this.smsSent,
    required super.isLoading,
    required super.authFailure,
  });

  PhoneAuthState.unknown():
        phoneNumber = '',
        smsCode = '',
        smsSent = false,
        super(
          isLoading: false,
          authFailure: AuthFailure.unknown(),
        );
  @override
  PhoneAuthState copyWith({
    String? phoneNumber,
    String? smsCode,
    bool? isLoading,
    AuthFailure? authFailure,
    bool? smsSent,
  }) {
    return PhoneAuthState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      smsCode: smsCode ?? this.smsCode,
      isLoading: isLoading ?? this.isLoading,
      authFailure: authFailure ?? this.authFailure,
      smsSent: smsSent ?? this.smsSent,
    );
  }
  @override
  List<Object?> get props => [phoneNumber, smsCode, isLoading, authFailure, smsSent];
}