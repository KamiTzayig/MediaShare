

import 'auth_user_model.dart';

abstract class AuthFeatureRepositoryBase{
  //example of an abstract repository which the data layer will implement

   AuthUser get authUser;
  //Notifies when the authentication status changes.
  Stream<AuthUser> get authUserStream;

  Stream<bool> get smsSentStream;

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> verifyEmail({
    required String email,
  });
  Future<void> signInWithGoogle({List<String>? scopes});

  Future<void> signInWithPhoneNumber({
    required String phoneNumber,
  });

  Future<void> verifySmsCode({
    required String smsCode,
  });

  //Logs out from the service.
  Future<void> signOut();

  }

