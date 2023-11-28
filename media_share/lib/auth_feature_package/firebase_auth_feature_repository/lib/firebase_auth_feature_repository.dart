import 'dart:async';
import 'dart:io' show Platform;


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../auth_feature_repository_base/lib/auth_failure.dart';
import '../../auth_feature_repository_base/lib/auth_feature_repository_base.dart';
import '../../auth_feature_repository_base/lib/auth_user_model.dart';
import 'firebase_auth_user_model.dart';

class FirebaseAuthFeatureRepository extends AuthFeatureRepositoryBase {
  //implement singleton pattern
  static final FirebaseAuthFeatureRepository _singleton =
  FirebaseAuthFeatureRepository._internal();

  FirebaseAuthFeatureRepository._internal();

  static FirebaseAuthFeatureRepository get instance => _singleton;

  late FirebaseAuth _auth;


  late ConfirmationResult confirmationResult;

  bool isWeb = false;
  bool isMobile = false;
  String verificationId = '';

  StreamController<bool> _smsSentStreamController = StreamController<bool>();

  Future<void> initialize(FirebaseOptions? options) async {
    await Firebase.initializeApp(
      options: options,
    );
    _auth = FirebaseAuth.instance;

    _smsSentStreamController.add(false);//init the stream

    try {
      if(Platform.isAndroid || Platform.isIOS || Platform.isFuchsia){
        isMobile = true;
      }else if (!Platform.isAndroid && !Platform.isIOS && !Platform.isFuchsia &&
          !Platform.isLinux && !Platform.isMacOS && !Platform.isWindows) {
        isWeb = true;
      }
    } catch (e) {
      //platform is web
      isWeb = true;
    }
  }

  @override
  Stream<AuthUser> get authUserStream =>
      _auth.authStateChanges().map<AuthUser>((User? user) {
        _smsSentStreamController.add(false);//reset the stream
        return FirebaseAuthUser.fromFirebaseUser(user: user);
      });

@override
  Stream<bool> get smsSentStream =>  _smsSentStreamController.stream;
  @override
  AuthUser get authUser =>
      FirebaseAuthUser.fromFirebaseUser(user: _auth.currentUser);




  @override
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String code = AuthFailureCode().fromStringCode(e.code);
      AuthFailure authFailure = AuthFailure(authFailureCode: code,
          authProviderType: AuthProviderType.email,
          message: e.message);
      throw authFailure;
    } catch (e) {
      throw AuthFailure(authFailureCode: AuthFailureCode.unknown,
          authProviderType: AuthProviderType.email,
          message: e.toString());
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String code = AuthFailureCode().fromStringCode(e.code);
      AuthFailure authFailure = AuthFailure(authFailureCode: code,
          authProviderType: AuthProviderType.email,
          message: e.message);
      throw authFailure;
    } catch (e) {
      throw AuthFailure(authFailureCode: AuthFailureCode.unknown,
          authProviderType: AuthProviderType.email,
          message: e.toString());
    }
  }

  @override
  Future<void> verifyEmail({required String email}) async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } catch (e) {
      throw AuthFailure(authFailureCode: AuthFailureCode.unknown,
          authProviderType: AuthProviderType.email,
          message: e.toString());
    }
  }

  @override
  Future<void> signInWithPhoneNumber({required String phoneNumber}) async {
    try {
          if(isMobile){

            await _auth.verifyPhoneNumber(
              phoneNumber: phoneNumber,
              verificationCompleted: (PhoneAuthCredential credential) async {
                await _auth.signInWithCredential(credential);
              },

              verificationFailed: (FirebaseAuthException e) {
                  throw e;
              },
              codeSent: (String verificationId, int? resendToken) async {
                // Update the UI - wait for the user to enter the SMS code
                verificationId = verificationId;
                _smsSentStreamController.add(true);
                },
              timeout: const Duration(seconds: 60),
              codeAutoRetrievalTimeout: (String verificationId) {
                // Auto-resolution timed out...
              },
            );

          }else{
            confirmationResult = await _auth.signInWithPhoneNumber(phoneNumber);
            _smsSentStreamController.add(true);


          }      // Your implementation for phone number sign-in here
    } on FirebaseAuthException catch (e) {
      String code = AuthFailureCode().fromStringCode(e.code);
      AuthFailure authFailure = AuthFailure(authFailureCode: code,
          authProviderType: AuthProviderType.phone,
          message: e.message);
      throw authFailure;
    } catch (e) {
      throw AuthFailure(authFailureCode: AuthFailureCode.unknown,
          authProviderType: AuthProviderType.phone,
          message: e.toString());
    }
  }

  @override
  Future<void> verifySmsCode({required String smsCode}) async {
    try {
      if(isMobile) {
        final PhoneAuthCredential phoneAuthCredential =
        PhoneAuthProvider.credential(
            smsCode: smsCode, verificationId: verificationId);

        await _auth.signInWithCredential(phoneAuthCredential);
      }else{
        await confirmationResult.confirm(smsCode);
      }

    } on FirebaseAuthException catch (e) {
      String code = AuthFailureCode().fromStringCode(e.code);
      AuthFailure authFailure = AuthFailure(authFailureCode: code,
          authProviderType: AuthProviderType.phone,
          message: e.message);
      throw authFailure;
    } catch (e) {
      throw AuthFailure(authFailureCode: AuthFailureCode.unknown,
          authProviderType: AuthProviderType.phone,
          message: e.toString());
    }
  }

  @override
  Future<void> signInWithGoogle({List<String>? scopes}) async {
    // Create a new provider
    try {
      if (isWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider.addScope(
            'https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({
          'login_hint': 'user@example.com'
        });

        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
      }
    } on FirebaseAuthException catch (e) {
      String code = AuthFailureCode().fromStringCode(e.code);
      AuthFailure authFailure = AuthFailure(authFailureCode: code,
          authProviderType: AuthProviderType.google,
          message: e.message);
      throw authFailure;
    } catch (e) {
      throw AuthFailure(authFailureCode: AuthFailureCode.unknown,
          authProviderType: AuthProviderType.google,
          message: e.toString());
    }
    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }


  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw AuthFailure(authFailureCode: AuthFailureCode.unknown,
          authProviderType: AuthProviderType.none,
          message: e.toString());
    }
  }


}
