import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constants/api_endpoints.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/networking/http_service.dart';
import 'package:job_finder/features/homepage/data/model/favorite_model.dart';
import 'package:job_finder/features/homepage/domain/entity/favorite_entity.dart';

final favoriteRemoteDataSourceProvider =
    Provider.autoDispose<FavoriteRemoteDataSource>(
  (ref) => FavoriteRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class FavoriteRemoteDataSource {
  final Dio dio;
  FavoriteRemoteDataSource({required this.dio});

  Future<Either<Failure, String>> addFavorite(FavoriteEntiry favorite) async {
    try {
      FavoriteAPIModel favoriteAPIModel = FavoriteAPIModel.fromEntity(favorite);
      var response = await dio.post(ApiEndpoints.getFavorite,
          data: favoriteAPIModel.toJson());

      if (response.statusCode == 201) {
        print("Response Data: ${response.data}");

        return Right(response.data["message"]);
      } else {
        return Left(Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
