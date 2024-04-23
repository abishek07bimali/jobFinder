import 'package:job_finder/features/homepage/domain/entity/favorite_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_model.g.dart';

@JsonSerializable()
class FavoriteAPIModel {
  @JsonKey(name: '_id')
  final String? favId;
  final String? likedJobsId;
  final String? userId;

  FavoriteAPIModel({this.favId, this.likedJobsId, this.userId});

  factory FavoriteAPIModel.fromJson(Map<String, dynamic> json) {
    return FavoriteAPIModel(
      favId: json['_id'],
      likedJobsId: json['likedJobsId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "likedJobsId": likedJobsId,
      "userId": userId,
    };
  }

  factory FavoriteAPIModel.fromEntity(FavoriteEntiry entity) {
    return FavoriteAPIModel(
      likedJobsId: entity.jobsId,
      userId: entity.userId,
    );
  }

  static FavoriteEntiry toEntity(FavoriteAPIModel model) {
    return FavoriteEntiry(
        jobsId: model.likedJobsId, userId: model.userId);
  }
}
