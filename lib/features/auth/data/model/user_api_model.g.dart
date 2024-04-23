// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAPIModel _$UserAPIModelFromJson(Map<String, dynamic> json) => UserAPIModel(
      userId: json['_id'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      image: json['image'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UserAPIModelToJson(UserAPIModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
      'password': instance.password,
      'image': instance.image,
    };
