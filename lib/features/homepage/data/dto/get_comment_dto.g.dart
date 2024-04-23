// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_comment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCommentDTO _$GetAllCommentDTOFromJson(Map<String, dynamic> json) =>
    GetAllCommentDTO(
      success: json['success'] as bool,
      comment: (json['comment'] as List<dynamic>)
          .map((e) => CommentAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCommentDTOToJson(GetAllCommentDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'comment': instance.comment,
    };
