import 'package:json_annotation/json_annotation.dart';

import '../model/jobs_api_model.dart';

part 'get_all_recommended_jobs_dto.g.dart';

@JsonSerializable()
class GetAllRecommendedJobsDTO {
  // final bool success;
  // final int count;
  final List<JobsAPIModel> recommendedJobs;

  GetAllRecommendedJobsDTO({ required this.recommendedJobs});

  factory GetAllRecommendedJobsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllRecommendedJobsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllRecommendedJobsDTOToJson(this);
}
