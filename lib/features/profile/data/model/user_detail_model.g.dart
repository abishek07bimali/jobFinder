// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailAPIModel _$UserDetailAPIModelFromJson(Map<String, dynamic> json) =>
    UserDetailAPIModel(
      userId: json['userId'] as String?,
      dob: json['dob'] as String?,
      fatherName: json['fatherName'] as String?,
      motherName: json['motherName'] as String?,
      grandfatherName: json['grandfatherName'] as String?,
      grandmotherName: json['grandmotherName'] as String?,
      educationLevel: json['educationLevel'] as String?,
      courseType: json['courseType'] as String?,
      courseName: json['courseName'] as String?,
      schoolName: json['schoolName'] as String?,
      educationBackground: json['educationBackground'] as String?,
      recentJobTitle: json['recentJobTitle'] as String?,
      jobType: json['jobType'] as String?,
      employmentDuration: json['employmentDuration'] as String?,
      companyName: json['companyName'] as String?,
      otherjobsDetail: json['otherjobsDetail'] as String?,
    );

Map<String, dynamic> _$UserDetailAPIModelToJson(UserDetailAPIModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'dob': instance.dob,
      'fatherName': instance.fatherName,
      'motherName': instance.motherName,
      'grandfatherName': instance.grandfatherName,
      'grandmotherName': instance.grandmotherName,
      'educationLevel': instance.educationLevel,
      'courseType': instance.courseType,
      'courseName': instance.courseName,
      'schoolName': instance.schoolName,
      'educationBackground': instance.educationBackground,
      'recentJobTitle': instance.recentJobTitle,
      'jobType': instance.jobType,
      'employmentDuration': instance.employmentDuration,
      'companyName': instance.companyName,
      'otherjobsDetail': instance.otherjobsDetail,
    };
