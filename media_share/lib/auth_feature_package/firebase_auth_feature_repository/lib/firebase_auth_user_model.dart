
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth_feature_repository_base/lib/auth_user_model.dart';

class FirebaseAuthUser extends AuthUser {
  FirebaseAuthUser({
    required String userId,
    required String phoneNumber,
    required String fullName,
    required String email,
    required bool emailIsVerified,
  }) : super(
    userId: userId,
    phoneNumber: phoneNumber,
    fullName: fullName,
    email: email,
    emailIsVerified: emailIsVerified,
  );

  factory FirebaseAuthUser.fromFirebaseUser({User? user}) {
    if (user == null) {
      return FirebaseAuthUser(
        userId: "",
        phoneNumber: "",
        fullName: "",
        email: "",
        emailIsVerified: false,
      );
    }
    return FirebaseAuthUser(
      userId: user.uid,
      phoneNumber: user.phoneNumber ?? "",
      fullName: user.displayName ?? "",
      email: user.email ?? "",
      emailIsVerified: user.emailVerified,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "phoneNumber": phoneNumber,
      "fullName": fullName,
      "email": email,
      "emailIsVerified": emailIsVerified,
    };
  }

  @override
  AuthUser copyWith({
    String? userId,
    String? phoneNumber,
    String? fullName,
    String? email,
    bool? emailIsVerified,
  }) {
    return FirebaseAuthUser(
      userId: userId ?? this.userId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      emailIsVerified: emailIsVerified ?? this.emailIsVerified,
    );
  }

  @override
  AuthUser fromJson(Map<String, dynamic> json) {
    return FirebaseAuthUser(
      userId: json["userId"],
      phoneNumber: json["phoneNumber"],
      fullName: json["fullName"],
      email: json["email"],
      emailIsVerified: json["emailIsVerified"],
    );
  }

  @override
  List<Object?> get props => [userId, phoneNumber, fullName, email, emailIsVerified];

  @override
  AuthUser unknown() {
    return FirebaseAuthUser(
      userId: "",
      phoneNumber: "",
      fullName: "",
      email: "",
      emailIsVerified: false,
    );
  }
}
