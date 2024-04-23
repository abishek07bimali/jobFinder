// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_application_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetApplicationDTO _$GetApplicationDTOFromJson(Map<String, dynamic> json) =>
    GetApplicationDTO(
      success: json['success'] as bool,
      applications: (json['applications'] as List<dynamic>)
          .map((e) => ApplicationAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetApplicationDTOToJson(GetApplicationDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'applications': instance.applications,
    };
