import 'package:job_finder/features/homepage/data/model/comment_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_comment_dto.g.dart';

@JsonSerializable()
class GetAllCommentDTO{
  final bool success;
  // final int count;
  final List<CommentAPIModel> comment;

  GetAllCommentDTO({required this.success,
   required this.comment});

  factory GetAllCommentDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllCommentDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCommentDTOToJson(this);
}