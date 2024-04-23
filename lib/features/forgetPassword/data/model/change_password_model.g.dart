// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordAPIModel _$ChangePasswordAPIModelFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordAPIModel(
      userId: json['userId'] as String?,
      oldPassword: json['oldPassword'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$ChangePasswordAPIModelToJson(
        ChangePasswordAPIModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };
