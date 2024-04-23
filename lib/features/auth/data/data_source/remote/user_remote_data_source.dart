import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constants/api_endpoints.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/networking/http_service.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/auth/data/model/user_api_model.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>(
  (ref) => UserRemoteDataSource(
      ref.read(httpServiceProvider), ref.read(userSharedPrefsProvider)),
);

class UserRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  UserRemoteDataSource(this.dio, this.userSharedPrefs);

  Future<Either<Failure, String>> adduser(UserEntity user) async {
    try {
      UserAPIModel userAPIModel = UserAPIModel.fromEntity(user);
      Response response =
          await dio.post(ApiEndpoints.register, data: userAPIModel.toJson());

      print("STATUS CODE IN DATA SOURCE::::::: ${response.data["success"]}");

      if (response.statusCode == 200) {
        String message = response.data['message'];
        return Right(message);
      } else {
        return Left(Failure(
          error: response.data['message'],
          status: response.data["success"],
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }

  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        // bool loginSuccess = response.data['success'];
        String message = response.data['message'];
        String token = response.data["token"];
        print("USER LOGIN RESPONSE::${response.data}");
        await userSharedPrefs.setUserToken(token);
        await userSharedPrefs.setUser(response.data['userData']);
        // var userdata = await userSharedPrefs.getUser();
        // print("USER LOGIN RESPONSE local::$userdata");

        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            status: response.data["success"],
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> updateUser(
      String id, UserEntity user, File? image) async {
    try {
      FormData formData;

      if (image != null) {
        String fileName = image.path.split('/').last;
        formData = FormData.fromMap(
          {
            'firstName': user.firstName,
            'lastName': user.lastName,
            'address': user.address,
            'phone': user.phone,
            'image': await MultipartFile.fromFile(
              image.path,
              filename: fileName,
            ),
          },
        );
      } else {
        formData = FormData.fromMap(
          {
            'firstName': user.firstName,
            'lastName': user.lastName,
            'address': user.address,
            'phone': user.phone,
          },
        );
      }

      Response response =
          await dio.put(ApiEndpoints.updateUsers + id, data: formData);

      if (response.statusCode == 200) {
        await userSharedPrefs.setUser(response.data['userData']);
        String message = response.data['message'];
        return Right(message);
      } else {
        return Left(Failure(
          error: response.data['message'],
          status: response.data["success"],
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
