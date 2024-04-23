import 'package:job_finder/features/homepage/domain/entity/application_entiry.dart';
import 'package:json_annotation/json_annotation.dart';

part 'application_model.g.dart';

@JsonSerializable()
class ApplicationAPIModel {
  @JsonKey(name: '_id')
  final String? applicationId;
  @JsonKey(name: 'jobsId')
  final String? jobId;
  final String? userId;
  final bool? isVerified;
  final bool? isRejected;
  final String? jobsTitle;
  final String? companyName;
  final String? interview;
  final String? image;

  ApplicationAPIModel({
    this.applicationId,
    this.jobId,
    this.userId,
    this.isVerified,
    this.isRejected,
    this.jobsTitle,
    this.companyName,
    this.interview,
    this.image,
  });

  factory ApplicationAPIModel.fromJson(Map<String, dynamic> json) {
    return ApplicationAPIModel(
      applicationId: json['_id'],
      jobId: json['jobsId']['_id'],
      userId: json['userId'],
      isVerified: json['isVerified'],
      isRejected: json['isRejected'],
      interview: json['interview'],
      jobsTitle: json['jobsId']['jobTitle'],
      companyName: json['jobsId']['companyName'],
      image: json['jobsId']['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": applicationId,
      "jobsId": jobId,
      "userId": userId,
      "isVerified": isVerified,
      "isRejected": isRejected,
      "jobsTitle": jobsTitle,
      "companyName": companyName,
      "interview": interview,
      "image": image,
    };
  }

  factory ApplicationAPIModel.fromEntity(ApplicationEntity entity) {
    return ApplicationAPIModel(
      jobId: entity.jobId,
      userId: entity.userId,
      isVerified: entity.isVerified,
      isRejected: entity.isRejected,
      jobsTitle: entity.jobsTitle,
      interview: entity.interview,
      companyName: entity.companyName,
      image: entity.image,
    );
  }

  static ApplicationEntity toEntity(ApplicationAPIModel model) {
    return ApplicationEntity(
      jobId: model.jobId,
      userId: model.userId,
      isVerified: model.isVerified,
      isRejected: model.isRejected,
      jobsTitle: model.jobsTitle,
      interview: model.interview,
      companyName: model.companyName,
      image: model.image,
    );
  }
}
