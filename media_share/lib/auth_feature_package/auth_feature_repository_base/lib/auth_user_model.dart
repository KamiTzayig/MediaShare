import 'package:equatable/equatable.dart';

abstract class AuthUser extends Equatable{
   final String userId;
   final String phoneNumber;
   final String fullName;
   final String email;
   final bool emailIsVerified;


  AuthUser({
    required this.userId,
    required this.phoneNumber,
    required this.fullName,
    required this.email,
    required this.emailIsVerified
  });
  AuthUser unknown();
  AuthUser copyWith();
  AuthUser fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  @override
  List<Object?> get props;


}