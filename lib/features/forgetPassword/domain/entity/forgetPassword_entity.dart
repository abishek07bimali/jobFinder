import 'package:equatable/equatable.dart';

class ForgetPasswordEntiry extends Equatable {
  final String? email;
  final String? password;
  final String? otp;


  const ForgetPasswordEntiry({
    this.email,
    this.password,
    this.otp,

  });

  @override
  List<Object?> get props => [
        email,
        password,
        otp,
      ];

  factory ForgetPasswordEntiry.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordEntiry(
      email: json['password'],
      password: json['password'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'otp': otp,

    };
  }

 
  @override
  String toString() {
    return 'ForgetPasswordEntiry(email: $email, password: $password, otp: $otp)';
  }
}
