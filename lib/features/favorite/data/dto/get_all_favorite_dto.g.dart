// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_favorite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllFavoriteDTO _$GetAllFavoriteDTOFromJson(Map<String, dynamic> json) =>
    GetAllFavoriteDTO(
      success: json['success'] as bool,
      likedJobsDetails: (json['likedJobsDetails'] as List<dynamic>)
          .map((e) => FavoriteAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllFavoriteDTOToJson(GetAllFavoriteDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'likedJobsDetails': instance.likedJobsDetails,
    };
