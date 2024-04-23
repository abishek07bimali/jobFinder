import 'package:json_annotation/json_annotation.dart';
import 'package:job_finder/features/homepage/domain/entity/comment_entity.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentAPIModel {
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'jobId')
  final String? jobId;
  @JsonKey(name: 'comment')
  final String? comment;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'image')
  final String? image;

  CommentAPIModel(
      {this.userId,
      this.jobId,
      this.comment,
      this.firstName,
      this.lastName,
      this.image});
  //
  // factory CommentAPIModel.fromJson(Map<String, dynamic> json) =>
  //     _$CommentAPIModelFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$CommentAPIModelToJson(this);

  factory CommentAPIModel.fromJson(Map<String, dynamic> json) {
    return CommentAPIModel(
      userId: json['userId']['_id'],
      jobId: json['jobId'],
      comment: json['comment'],
      firstName: json['userId']['firstName'],
      lastName: json['userId']['lastName'],
      image: json['userId']['image'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'jobId': jobId,
      'comment': comment,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
    };
  }

  factory CommentAPIModel.fromEntity(CommentEntity entity) {
    return CommentAPIModel(
      userId: entity.userId,
      jobId: entity.jobId,
      comment: entity.comment,
      firstName: entity.firstName,
      lastName: entity.lastName,
      image: entity.image,
    );
  }

  static CommentEntity toEntity(CommentAPIModel model) {
    return CommentEntity(
      userId: model.userId,
      jobId: model.jobId,
      comment: model.comment,
      firstName: model.firstName,
      lastName: model.lastName,
      image: model.image,
    );
  }
}
