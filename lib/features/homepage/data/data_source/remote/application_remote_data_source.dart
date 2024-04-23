import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constants/api_endpoints.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/networking/http_service.dart';
import 'package:job_finder/features/homepage/data/dto/get_application_dto.dart';
import 'package:job_finder/features/homepage/data/model/application_model.dart';
import 'package:job_finder/features/homepage/domain/entity/application_entiry.dart';

final applicationRemoteDataSourceProvider =
    Provider.autoDispose<ApplicationRemoteDataSource>(
  (ref) => ApplicationRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class ApplicationRemoteDataSource {
  final Dio dio;
  ApplicationRemoteDataSource({required this.dio});

  Future<Either<Failure, String>> addApplication(
      ApplicationEntity favorite) async {
    try {
      ApplicationAPIModel favoriteAPIModel =
          ApplicationAPIModel.fromEntity(favorite);
      var response = await dio.post(ApiEndpoints.postApplication,
          data: favoriteAPIModel.toJson());
      if (response.statusCode == 200) {
        String message = response.data["message"];
        return Right(message);
      } else {
        return Left(Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }

  Future<Either<Failure, List<ApplicationEntity>>> fetchApplicationsForUser(
      String userId) async {
    try {
      Response response = await dio.get(ApiEndpoints.getApplication + userId);
      print("RESPONSE FROM APPLICATION: $response");

      if (response.statusCode == 200) {
        GetApplicationDTO getAllJobsDTO =
            GetApplicationDTO.fromJson(response.data);
        List<ApplicationEntity> applications = getAllJobsDTO.applications
            .map((application) => ApplicationAPIModel.toEntity(application))
            .toList();
        return Right(applications);
      } else {
        print("Failed to fetch applications: ${response.statusCode}");
        return Left(Failure(
            error: 'Failed to fetch applications: ${response.statusCode}'));
      }
    } catch (e) {
      print("Failed to fetch applications: $e");
      return Left(Failure(error: 'Failed to fetch applications: $e'));
    }
  }
}
