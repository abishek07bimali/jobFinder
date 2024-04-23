import 'package:json_annotation/json_annotation.dart';

import '../model/jobs_api_model.dart';

part 'get_all_jobs_dto.g.dart';

@JsonSerializable()
class GetAllJobsDTO{
  final bool success;
  // final int count;
  final List<JobsAPIModel> jobs;

  GetAllJobsDTO({required this.success,
   required this.jobs});

  factory GetAllJobsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllJobsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllJobsDTOToJson(this);
}