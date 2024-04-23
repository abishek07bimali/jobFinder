// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationAPIModel _$ApplicationAPIModelFromJson(Map<String, dynamic> json) =>
    ApplicationAPIModel(
      applicationId: json['_id'] as String?,
      jobId: json['jobsId'] as String?,
      userId: json['userId'] as String?,
      isVerified: json['isVerified'] as bool?,
      isRejected: json['isRejected'] as bool?,
      jobsTitle: json['jobsTitle'] as String?,
      companyName: json['companyName'] as String?,
      interview: json['interview'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ApplicationAPIModelToJson(
        ApplicationAPIModel instance) =>
    <String, dynamic>{
      '_id': instance.applicationId,
      'jobsId': instance.jobId,
      'userId': instance.userId,
      'isVerified': instance.isVerified,
      'isRejected': instance.isRejected,
      'jobsTitle': instance.jobsTitle,
      'companyName': instance.companyName,
      'interview': instance.interview,
      'image': instance.image,
    };
