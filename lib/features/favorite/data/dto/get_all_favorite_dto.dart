import 'package:json_annotation/json_annotation.dart';

import '../model/favorite_api_model.dart';

part 'get_all_favorite_dto.g.dart';

@JsonSerializable()
class GetAllFavoriteDTO {
  final bool success;
  final List<FavoriteAPIModel> likedJobsDetails;

  GetAllFavoriteDTO({
    required this.success,
    required this.likedJobsDetails,
  });

  factory GetAllFavoriteDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllFavoriteDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllFavoriteDTOToJson(this);
}
