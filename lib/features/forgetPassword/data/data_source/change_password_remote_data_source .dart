import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constants/api_endpoints.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/networking/http_service.dart';
import 'package:job_finder/features/forgetPassword/data/model/change_password_model.dart';
import 'package:job_finder/features/forgetPassword/domain/entity/change_password_entity.dart';

final changePasswordRemoteDataSourceProvider =
    Provider.autoDispose<ChangePasswordRemoteDataSource>(
  (ref) => ChangePasswordRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class ChangePasswordRemoteDataSource {
  final Dio dio;

  ChangePasswordRemoteDataSource({
    required this.dio,
  });

  Future<Either<Failure, String>> changePassword(
      ChangePasswordEntity changePasswordEntiry) async {
    try {
      ChangePasswordAPIModel changePasswordAPIModel =
          ChangePasswordAPIModel.fromEntity(changePasswordEntiry);
      var response = await dio.put(ApiEndpoints.changePassword,
          data: changePasswordAPIModel.toJson());

      if (response.statusCode == 201) {
        print("Response Data: ${response.data}");

        return Right(response.data["message"]);
      } else {
        return Left(Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
