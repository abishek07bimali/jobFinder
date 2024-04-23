// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteAPIModel _$FavoriteAPIModelFromJson(Map<String, dynamic> json) =>
    FavoriteAPIModel(
      jobsId: json['_id'] as String,
      jobsTitle: json['jobsTitle'] as String,
      companyName: json['companyName'] as String,
      location: json['location'] as String,
      jobType: json['jobType'] as String,
      salary: json['salary'] as String,
      experianceLevel: json['experianceLevel'] as String,
      educationLevel: json['educationLevel'] as String,
      jobDescription: json['jobDescription'] as String,
      jobResponsibilities: json['jobResponsibilities'] as String,
      contact: json['contact'] as String,
      workType: json['workType'] as String,
      companyOverview: json['companyOverview'] as String,
      applyBefore: json['applyBefore'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$FavoriteAPIModelToJson(FavoriteAPIModel instance) =>
    <String, dynamic>{
      '_id': instance.jobsId,
      'jobsTitle': instance.jobsTitle,
      'companyName': instance.companyName,
      'location': instance.location,
      'jobType': instance.jobType,
      'salary': instance.salary,
      'experianceLevel': instance.experianceLevel,
      'educationLevel': instance.educationLevel,
      'jobDescription': instance.jobDescription,
      'jobResponsibilities': instance.jobResponsibilities,
      'contact': instance.contact,
      'workType': instance.workType,
      'companyOverview': instance.companyOverview,
      'image': instance.image,
      'applyBefore': instance.applyBefore,
    };
