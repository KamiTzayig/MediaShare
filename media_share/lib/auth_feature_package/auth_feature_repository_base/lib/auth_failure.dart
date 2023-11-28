class AuthFailure {
  final String authFailureCode;
  final AuthProviderType authProviderType;

  final String? message;

  const AuthFailure({
    required this.authFailureCode,
    required this.authProviderType,
    required this.message,
  });

  AuthFailure.unknown():
        authFailureCode = AuthFailureCode.none,
        authProviderType = AuthProviderType.none,
        message = '';
}
//replace the following enum with a map to string of the same values

enum AuthProviderType {
  none,
  email,
  phone,
  google,
  facebook,
  apple,
  anonymous,
  custom
}

class AuthFailureCode {
  static const String none = 'none';
  static const String unknown = 'unknown';
  static const String server_error = 'serverError';

  static const String network_request_failed = 'networkRequestError';

  static const String too_many_requests = 'tooManyRequests';
  static const String invalid_mail = 'invalidMail';
  static const String mail_already_in_use = 'mailAlreadyInUse';
  static const String mail_is_not_in_use = 'mailIsNotInUse';
  static const String invalid_password = 'invalidPassword';
  static const String wrong_password = 'wrongPassword';
  static const String invalid_phone_number = 'invalidPhoneNumber';
  static const String sms_timeout = 'smsTimeout';
  static const String session_expired = 'sessionExpired';
  static const String operation_not_allowed = 'operationNotAllowed';
  static const String weak_password = 'weakPassword';
  static const String account_exists_with_different_credential =
      'account-exists-with-different-credential';
  static const String invalid_credential = 'invalid-credential';
  static const String user_disabled = 'user-disabled';
  static const String user_not_found = 'user-not-found';
  static const String invalid_verification_code = 'invalid-verification-code';
  static const String invalid_verification_id = 'invalid-verification-id';

  String fromStringCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return mail_already_in_use;
      case 'invalid-email':
        return invalid_mail;
      case 'operation-not-allowed':
        return operation_not_allowed;
      case 'weak-password':
        return weak_password;
      case 'account-exists-with-different-credential':
        return account_exists_with_different_credential;
      case 'invalid-login-credentials':
      case 'invalid-credential':
        return invalid_credential;
      case 'user-disabled':
        return user_disabled;
      case 'user-not-found':
        return user_not_found;
      case 'auth/wrong-password':
        return invalid_password;
      case 'invalid-verification-code':
        return invalid_verification_code;
      case 'invalid-verification-id':
        return invalid_verification_id;
      case 'network-request-failed':
        return network_request_failed;

      default:
        print('AuthFailure unknown code: $code');
        return unknown;
    }
  }
}
