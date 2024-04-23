import 'package:job_finder/features/profile/domain/entity/userDetail_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_detail_model.g.dart';

@JsonSerializable()
class UserDetailAPIModel {
  final String? userId;
  final String? dob;
  final String? fatherName;
  final String? motherName;
  final String? grandfatherName;
  final String? grandmotherName;
  final String? educationLevel;
  final String? courseType;
  final String? courseName;
  final String? schoolName;
  final String? educationBackground;
  final String? recentJobTitle;
  final String? jobType;
  final String? employmentDuration;
  final String? companyName;
  final String? otherjobsDetail;

  UserDetailAPIModel({
    this.userId,
    this.dob,
    this.fatherName,
    this.motherName,
    this.grandfatherName,
    this.grandmotherName,
    this.educationLevel,
    this.courseType,
    this.courseName,
    this.schoolName,
    this.educationBackground,
    this.recentJobTitle,
    this.jobType,
    this.employmentDuration,
    this.companyName,
    this.otherjobsDetail,
  });

  factory UserDetailAPIModel.fromJson(Map<String, dynamic> json) {
    return UserDetailAPIModel(
      userId: json['userId'],
      dob: json['dob'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      grandfatherName: json['grandfatherName'],
      grandmotherName: json['grandmotherName'],
      educationLevel: json['educationLevel'],
      courseType: json['courseType'],
      courseName: json['courseName'],
      schoolName: json['schoolName'],
      educationBackground: json['educationBackground'],
      recentJobTitle: json['recentJobTitle'],
      jobType: json['jobType'],
      employmentDuration: json['employmentDuration'],
      companyName: json['companyName'],
      otherjobsDetail: json['otherjobsDetail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'dob': dob,
      'fatherName': fatherName,
      'motherName': motherName,
      'grandfatherName': grandfatherName,
      'grandmotherName': grandmotherName,
      'educationLevel': educationLevel,
      'courseType': courseType,
      'courseName': courseName,
      'schoolName': schoolName,
      'educationBackground': educationBackground,
      'recentJobTitle': recentJobTitle,
      'jobType': jobType,
      'employmentDuration': employmentDuration,
      'companyName': companyName,
      'otherjobsDetail': otherjobsDetail,
    };
  }

  factory UserDetailAPIModel.fromEntity(UserDetailEntity entity) {
    return UserDetailAPIModel(
      userId: entity.userId,
      dob: entity.dob,
      fatherName: entity.fatherName,
      motherName: entity.motherName,
      grandfatherName: entity.grandfatherName,
      grandmotherName: entity.grandmotherName,
      educationLevel: entity.educationLevel,
      courseType: entity.courseType,
      courseName: entity.courseName,
      schoolName: entity.schoolName,
      educationBackground: entity.educationBackground,
      recentJobTitle: entity.recentJobTitle,
      jobType: entity.jobType,
      employmentDuration: entity.employmentDuration,
      companyName: entity.companyName,
      otherjobsDetail: entity.otherjobsDetail,
    );
  }

  static UserDetailEntity toEntity(UserDetailAPIModel model) {
    return UserDetailEntity(
      userId: model.userId,
      dob: model.dob,
      fatherName: model.fatherName,
      motherName: model.motherName,
      grandfatherName: model.grandfatherName,
      grandmotherName: model.grandmotherName,
      educationLevel: model.educationLevel,
      courseType: model.courseType,
      courseName: model.courseName,
      schoolName: model.schoolName,
      educationBackground: model.educationBackground,
      recentJobTitle: model.recentJobTitle,
      jobType: model.jobType,
      employmentDuration: model.employmentDuration,
      companyName: model.companyName,
      otherjobsDetail: model.otherjobsDetail,
    );
  }
}
