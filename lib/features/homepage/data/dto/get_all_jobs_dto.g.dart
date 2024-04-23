// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_jobs_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllJobsDTO _$GetAllJobsDTOFromJson(Map<String, dynamic> json) =>
    GetAllJobsDTO(
      success: json['success'] as bool,
      jobs: (json['jobs'] as List<dynamic>)
          .map((e) => JobsAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllJobsDTOToJson(GetAllJobsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'jobs': instance.jobs,
    };
