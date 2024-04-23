import 'package:hive_flutter/hive_flutter.dart';
import 'package:job_finder/config/constants/hive_table_constant.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';
import 'package:uuid/uuid.dart';

part 'jobs_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.jobsTableId)
class JobsHiveModel {
  @HiveField(0)
  final String jobsId;
  @HiveField(1)
  final String jobsTitle;
  @HiveField(2)
  final String companyName;
  @HiveField(3)
  final String location;
  @HiveField(4)
  final String jobType;
  @HiveField(5)
  final String experianceLevel;
  @HiveField(6)
  final String educationLevel;
  @HiveField(7)
  final String jobDescription;
  @HiveField(8)
  final String jobResponsibilities;
  @HiveField(9)
  final String contact;
  @HiveField(10)
  final String workType;
  @HiveField(11)
  final String image;
    @HiveField(12)
  final String salary;
    @HiveField(13)
  final String companyOverview;
    @HiveField(14)
  final String applyBefore;
  //   @HiveField(13)
  // final List jobTags;

  JobsHiveModel.empty()
      : this(
          jobsId: '',
          jobsTitle: '',
          companyName: '',
          location: '',
          jobType: '',
          experianceLevel: '',
          educationLevel: '',
          jobDescription: '',
          jobResponsibilities: '',
          contact: '',
          workType: '',
          image: '',
          salary: '',
          companyOverview: '',
          applyBefore: '',
          // jobTags: [],
        );

  JobsHiveModel(
      {String? jobsId,
      required this.jobsTitle,
      required this.companyName,
      required this.location,
      required this.jobType,
      required this.experianceLevel,
      required this.educationLevel,
      required this.jobDescription,
      required this.jobResponsibilities,
      required this.contact,
      required this.workType,
      required this.salary,
      required this.companyOverview,
      required this.applyBefore,
      // required this.jobTags,
      required this.image})
      : jobsId = jobsId ?? const Uuid().v4();

  factory JobsHiveModel.toHiveModel(JobsEntity entity) => JobsHiveModel(
        jobsTitle: entity.jobsTitle,
        companyName: entity.companyName,
        location: entity.location,
        jobType: entity.jobType,
        salary: entity.salary,
        experianceLevel: entity.experianceLevel,
        educationLevel: entity.educationLevel,
        jobResponsibilities: entity.jobResponsibilities,
        jobDescription: entity.jobDescription,
        contact: entity.contact,
        workType: entity.workType,
        companyOverview: entity.companyOverview,
        image: entity.image,
        applyBefore: entity.applyBefore,
        // jobTags: entity.jobTags,
      );
  static JobsEntity toEntity(JobsHiveModel hivemodel) => JobsEntity(
        jobsTitle: hivemodel.jobsTitle,
        companyName: hivemodel.companyName,
        location: hivemodel.location,
        jobType: hivemodel.jobType,
        salary: hivemodel.salary,
        experianceLevel: hivemodel.experianceLevel,
        educationLevel: hivemodel.educationLevel,
        jobResponsibilities: hivemodel.jobResponsibilities,
        jobDescription: hivemodel.jobDescription,
        contact: hivemodel.contact,
        workType: hivemodel.workType,
        image: hivemodel.image,
        companyOverview: hivemodel.companyOverview,
        applyBefore: hivemodel.applyBefore,
        // jobTags:hivemodel.jobTags,
      );
}
