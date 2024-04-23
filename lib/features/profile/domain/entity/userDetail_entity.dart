import 'package:equatable/equatable.dart';

class UserDetailEntity extends Equatable {
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

  const UserDetailEntity({
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

  @override
  List<Object?> get props => [
        userId,
        dob,
        fatherName,
        motherName,
        grandfatherName,
        grandmotherName,
        educationLevel,
        courseType,
        courseName,
        schoolName,
        educationBackground,
        recentJobTitle,
        jobType,
        employmentDuration,
        companyName,
        otherjobsDetail,
      ];

  factory UserDetailEntity.fromJson(Map<String, dynamic> json) {
    return UserDetailEntity(
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

  UserDetailEntity copyWith({
    String? userId,
    String? dob,
    String? fatherName,
    String? motherName,
    String? grandfatherName,
    String? grandmotherName,
    String? educationLevel,
    String? courseType,
    String? courseName,
    String? schoolName,
    String? educationBackground,
    String? recentJobTitle,
    String? jobType,
    String? employmentDuration,
    String? companyName,
    String? otherjobsDetail,
  }) {
    return UserDetailEntity(
      userId: userId ?? this.userId,
      dob: dob ?? this.dob,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      grandfatherName: grandfatherName ?? this.grandfatherName,
      grandmotherName: grandmotherName ?? this.grandmotherName,
      educationLevel: educationLevel ?? this.educationLevel,
      courseType: courseType ?? this.courseType,
      courseName: courseName ?? this.courseName,
      schoolName: schoolName ?? this.schoolName,
      educationBackground: educationBackground ?? this.educationBackground,
      recentJobTitle: recentJobTitle ?? this.recentJobTitle,
      jobType: jobType ?? this.jobType,
      employmentDuration: employmentDuration ?? this.employmentDuration,
      companyName: companyName ?? this.companyName,
      otherjobsDetail: otherjobsDetail ?? this.otherjobsDetail,
    );
  }

  @override
  String toString() {
    return 'UserDetailEntity(userId: $userId, dob: $dob, fatherName: $fatherName, motherName: $motherName, grandfatherName: $grandfatherName, grandmotherName: $grandmotherName, educationLevel: $educationLevel, courseType: $courseType, courseName: $courseName, schoolName: $schoolName, educationBackground: $educationBackground, recentJobTitle: $recentJobTitle, jobType: $jobType, employmentDuration: $employmentDuration, companyName: $companyName, otherjobsDetail: $otherjobsDetail)';
  }
}
