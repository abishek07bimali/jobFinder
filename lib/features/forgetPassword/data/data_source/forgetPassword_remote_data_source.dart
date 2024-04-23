import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constants/api_endpoints.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/networking/http_service.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/forgetPassword/data/model/forgetPassword_model.dart';
import 'package:job_finder/features/forgetPassword/domain/entity/forgetPassword_entity.dart';

final forgetPasswordRemoteDataSourceProvider =
    Provider.autoDispose<ForgetPasswordRemoteDataSource>(
  (ref) => ForgetPasswordRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class ForgetPasswordRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  ForgetPasswordRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

    Future<Either<Failure, String>> forgetPassword(ForgetPasswordEntiry forgetPasswordEntiry) async {
        try {
      ForgetPasswordAPIModel forgetPasswordAPIModel =
          ForgetPasswordAPIModel.fromEntity(forgetPasswordEntiry);
      var response = await dio.post(ApiEndpoints.forgetPassword ,
          data: forgetPasswordAPIModel.toJson());

      if (response.statusCode == 200) {
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


     Future<Either<Failure, String>> verifyOTP(ForgetPasswordEntiry forgetPasswordEntiry) async {
        try {
      ForgetPasswordAPIModel forgetPasswordAPIModel =
          ForgetPasswordAPIModel.fromEntity(forgetPasswordEntiry);
      var response = await dio.post(ApiEndpoints.verifyOtp ,
          data: forgetPasswordAPIModel.toJson());

      if (response.statusCode == 200) {
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

     Future<Either<Failure, String>> changePassword(ForgetPasswordEntiry forgetPasswordEntiry) async {
        try {
      ForgetPasswordAPIModel forgetPasswordAPIModel =
          ForgetPasswordAPIModel.fromEntity(forgetPasswordEntiry);
      var response = await dio.post(ApiEndpoints.resetPassword ,
          data: forgetPasswordAPIModel.toJson());

      if (response.statusCode == 200) {
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
