// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentAPIModel _$CommentAPIModelFromJson(Map<String, dynamic> json) =>
    CommentAPIModel(
      userId: json['userId'] as String?,
      jobId: json['jobId'] as String?,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$CommentAPIModelToJson(CommentAPIModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'jobId': instance.jobId,
      'comment': instance.comment,
    };
