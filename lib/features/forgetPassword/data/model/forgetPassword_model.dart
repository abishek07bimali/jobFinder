import 'package:job_finder/features/forgetPassword/domain/entity/forgetPassword_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgetPassword_model.g.dart';

@JsonSerializable()
class ForgetPasswordAPIModel {
  final String? email;
  final String? password;
  final String? otp;

  ForgetPasswordAPIModel({
    this.email,
    this.password,
    this.otp,
  });

  factory ForgetPasswordAPIModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordAPIModel(
      email: json['email'],
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

  factory ForgetPasswordAPIModel.fromEntity(ForgetPasswordEntiry entity) {
    return ForgetPasswordAPIModel(
        email: entity.email, password: entity.password, otp: entity.otp);
  }

  static ForgetPasswordEntiry toEntity(ForgetPasswordAPIModel model) {
    return ForgetPasswordEntiry(
      email: model.email,
      password: model.password,
      otp: model.otp,

    );
  }
}
