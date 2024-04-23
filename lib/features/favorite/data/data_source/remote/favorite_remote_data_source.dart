import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constants/api_endpoints.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/networking/http_service.dart';
import 'package:job_finder/features/favorite/data/dto/get_all_favorite_dto.dart';
import 'package:job_finder/features/favorite/data/model/favorite_api_model.dart';
import 'package:job_finder/features/favorite/domain/entity/favorite_entity.dart';

final FavoriteRemoteDataSourceProvider =
    Provider.autoDispose<FavoriteRemoteDataSource>(
  (ref) => FavoriteRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class FavoriteRemoteDataSource {
  final Dio dio;

  FavoriteRemoteDataSource({required this.dio});

  Future<Either<Failure, List<FavoriteEntity>>> getAllFavorite(
      String userId) async {
    try {
      var response = await dio.get(ApiEndpoints.getFavoriteJobs + userId);
      if (response.statusCode == 200) {
        GetAllFavoriteDTO getAllFavoriteDTO =
            GetAllFavoriteDTO.fromJson(response.data);
        List<FavoriteEntity> favoriteList = getAllFavoriteDTO.likedJobsDetails
            .map(
              (jobs) => FavoriteAPIModel.toEntity(jobs),
            )
            .toList();
        print("DATA FROM THE REMOTE SOURCE FETCHED AND PASSED:::");
        return Right(favoriteList);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
