import 'package:equatable/equatable.dart';

class ApplicationEntity extends Equatable {
  final String? applicationId;
  final String? jobId;
  final String? jobsTitle;
  final String? companyName;
  final String? image;
  final String? userId;
  final String? interview;
  final bool? isVerified;
  final bool? isRejected;

  @override
  List<Object?> get props => [applicationId, jobId, userId];
  const ApplicationEntity(
      {this.applicationId,
      this.jobId,
      this.userId,
      this.isRejected,
      this.companyName,
      this.jobsTitle,
      this.image,
      this.interview,
      this.isVerified});

  factory ApplicationEntity.fromJson(Map<String, dynamic> json) =>
      ApplicationEntity(
        applicationId: json["applicationId"],
        jobId: json["jobsId"],
        jobsTitle: json["jobsId"]["jobsTitle"],
        companyName: json["jobsId"]["companyName"],
        image: json["jobsId"]["image"],
        userId: json["userId"],
        interview: json["interview"],
        isRejected: json["isRejected"],
        isVerified: json["isVerified"],
      );

  Map<String, dynamic> toJson() => {
        "applicationId": applicationId,
        "jobId": jobId,
        "jobsTitle": jobsTitle,
        "companyName": companyName,
        "image": image,
        "userId": userId,
        "interview": interview,
        "isRejected": isRejected,
        "isVerified": isVerified,
      };

  @override
  String toString() {
    return 'ApplicationEntiry(applicationId: $applicationId,jobId: $jobId,jobsTitle: $jobsTitle,companyName:$companyName,image:$image,interview:$interview,userId: $userId,isRejected:$isRejected,isVerified:$isVerified))';
  }
  // Conversion method to JobsEntity
  // JobsEntity toJobsEntity() {
  //   return JobsEntity(
  //     jobsId: jobsId,
  //     jobsTitle: jobsTitle,
  //     companyName: companyName,
  //     location: location,
  //     jobType: jobType,
  //     salary: salary,
  //     experianceLevel: experianceLevel,
  //     educationLevel: educationLevel,
  //     jobDescription: jobDescription,
  //     jobResponsibilities: jobResponsibilities,
  //     contact: contact,
  //     workType: workType,
  //     image: image,
  //     companyOverview: companyOverview,
  //     applyBefore: applyBefore,
  //   );
  // }
}
