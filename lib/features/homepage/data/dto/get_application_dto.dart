import 'package:job_finder/features/homepage/data/model/application_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_application_dto.g.dart';

@JsonSerializable()
class GetApplicationDTO {
  final bool success;
  final List<ApplicationAPIModel> applications;

  GetApplicationDTO({
    required this.success,
    required this.applications,
  });

  factory GetApplicationDTO.fromJson(Map<String, dynamic> json) =>
      _$GetApplicationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetApplicationDTOToJson(this);
}
