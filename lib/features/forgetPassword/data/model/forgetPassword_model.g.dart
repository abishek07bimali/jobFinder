// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgetPassword_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordAPIModel _$ForgetPasswordAPIModelFromJson(
        Map<String, dynamic> json) =>
    ForgetPasswordAPIModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
      otp: json['otp'] as String?,
    );

Map<String, dynamic> _$ForgetPasswordAPIModelToJson(
        ForgetPasswordAPIModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'otp': instance.otp,
    };
