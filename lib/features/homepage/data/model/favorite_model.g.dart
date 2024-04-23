// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteAPIModel _$FavoriteAPIModelFromJson(Map<String, dynamic> json) =>
    FavoriteAPIModel(
      favId: json['_id'] as String?,
      likedJobsId: json['likedJobsId'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$FavoriteAPIModelToJson(FavoriteAPIModel instance) =>
    <String, dynamic>{
      '_id': instance.favId,
      'likedJobsId': instance.likedJobsId,
      'userId': instance.userId,
    };
