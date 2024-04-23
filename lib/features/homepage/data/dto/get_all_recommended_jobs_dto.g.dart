// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_recommended_jobs_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllRecommendedJobsDTO _$GetAllRecommendedJobsDTOFromJson(
        Map<String, dynamic> json) =>
    GetAllRecommendedJobsDTO(
      recommendedJobs: (json['recommendedJobs'] as List<dynamic>)
          .map((e) => JobsAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllRecommendedJobsDTOToJson(
        GetAllRecommendedJobsDTO instance) =>
    <String, dynamic>{
      'recommendedJobs': instance.recommendedJobs,
    };
