import 'package:equatable/equatable.dart';

class JobsEntity extends Equatable {
  final String? jobsId;
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
  // final List jobTags;
  final String image;
  final String companyOverview;
  final String applyBefore;

  @override
  List<Object?> get props => [
        jobsId,
        jobsTitle,
        companyName,
        location,
        jobType,
        salary,
        experianceLevel,
        educationLevel,
        jobDescription,
        jobResponsibilities,
        contact,
        workType,
        // jobTags,
        image,
        companyOverview,
        applyBefore
      ];

  const JobsEntity({
    this.jobsId,
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
    // required this.jobTags,
    required this.image,
    required this.companyOverview,
    required this.applyBefore,
  });

  factory JobsEntity.fromJson(Map<String, dynamic> json) => JobsEntity(
        jobsId: json["jobsId"],
        jobsTitle: json["jobsTitle"],
        companyName: json["companyName"],
        location: json["location"],
        jobType: json["jobType"],
        salary: json["salary"],
        experianceLevel: json["experianceLevel"],
        educationLevel: json["educationLevel"],
        jobDescription: json["jobDescription"],
        jobResponsibilities: json["jobResponsibilities"],
        contact: json["contact"],
        workType: json["workType"],
        // jobTags: json["jobTags"],
        image: json["image"],
        companyOverview: json["companyOverview"],
        applyBefore: json["applyBefore"],
      );

  Map<String, dynamic> toJson() => {
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
        // "jobTags": jobTags,
        "image": image,
        "companyOverview": companyOverview,
        "applyBefore": applyBefore,
      };

  @override
  String toString() {
    return 'JobsEntity(jobsId: $jobsId, jobsTitle: $jobsTitle,applyBefore:$applyBefore,companyName:$companyName,location:$location,jobType:$jobType,experianceLevel:$experianceLevel,educationLevel:$educationLevel,jobDescription:$jobDescription,jobResponsibilities:$jobResponsibilities,contact:$contact,workType:$workType,image: $image,companyOverview:$companyOverview))';
  }
}
