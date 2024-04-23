import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/favorite_entity.dart';

part 'favorite_api_model.g.dart';

@JsonSerializable()
class FavoriteAPIModel {
  @JsonKey(name: '_id')
  final String jobsId;
  final String jobsTitle;
  final String companyName;
  final String location;
  final String jobType;
  final String salary;
  final String experianceLevel;
  final String educationLevel;
  final String jobDescription;
  final String jobResponsibilities;
  final String contact;
  final String workType;
  final String companyOverview;
  // final List jobTags;
  final String image;
  final String applyBefore;

  FavoriteAPIModel(
      {required this.jobsId,
      required this.jobsTitle,
      required this.companyName,
      required this.location,
      required this.jobType,
      required this.salary,
      required this.experianceLevel,
      required this.educationLevel,
      required this.jobDescription,
      required this.jobResponsibilities,
      required this.contact,
      required this.workType,
      required this.companyOverview,
      required this.applyBefore,
      required this.image});

  factory FavoriteAPIModel.fromJson(Map<String, dynamic> json) {
    return FavoriteAPIModel(
      jobsId: json['_id'] ?? '',
      jobsTitle: json['jobTitle'] ?? '',
      companyName: json["companyName"] ?? '',
      location: json["location"] ?? '',
      jobType: json["jobType"] ?? '',
      salary: json["salary"] ?? '',
      experianceLevel: json["experianceLevel"] ?? '',
      educationLevel: json["educationLevel"] ?? '',
      jobDescription: json["jobDescription"] ?? '',
      jobResponsibilities: json["jobResponsibilities"] ?? '',
      contact: json["contact"] ?? '',
      workType: json["workType"] ?? '',
      image: json['image'] ?? '',
      companyOverview: json['companyOverview'] ?? '',
      applyBefore: json['applyBefore'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "jobsId": jobsId,
      "jobsTitle": jobsTitle,
      "companyName": companyName,
      "location": location,
      "jobType": jobType,
      "salary": salary,
      "experianceLevel": experianceLevel,
      "educationLevel": educationLevel,
      "jobDescription": jobDescription,
      "jobResponsibilities": jobResponsibilities,
      "contact": contact,
      "workType": workType,
      "companyOverview": companyOverview,
      // "jobTags": jobTags,
      "image": image,
    };
  }

  // From entity to model
  factory FavoriteAPIModel.fromEntity(FavoriteEntity entity) {
    return FavoriteAPIModel(
      jobsId: entity.jobsId,
      jobsTitle: entity.jobsTitle,
      companyName: entity.companyName,
      location: entity.location,
      jobType: entity.jobType,
      salary: entity.salary,
      experianceLevel: entity.experianceLevel,
      educationLevel: entity.educationLevel,
      jobDescription: entity.jobDescription,
      jobResponsibilities: entity.jobResponsibilities,
      contact: entity.contact,
      workType: entity.workType,
      companyOverview: entity.companyOverview,
      // jobTags: entity.jobTags,
      image: entity.image,
      applyBefore: entity.applyBefore,
    );
  }

  // From model to entity
  static FavoriteEntity toEntity(FavoriteAPIModel model) {
    return FavoriteEntity(
      jobsId: model.jobsId,
      jobsTitle: model.jobsTitle,
      companyName: model.companyName,
      location: model.location,
      jobType: model.jobType,
      salary: model.salary,
      experianceLevel: model.experianceLevel,
      educationLevel: model.educationLevel,
      jobDescription: model.jobDescription,
      jobResponsibilities: model.jobResponsibilities,
      contact: model.contact,
      workType: model.workType,
      companyOverview: model.companyOverview,
      // jobTags: model.jobTags,
      image: model.image,
      applyBefore: model.applyBefore,
    );
  }
}
