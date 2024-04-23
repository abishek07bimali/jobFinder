import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constants/api_endpoints.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/networking/http_service.dart';
import 'package:job_finder/features/profile/data/model/user_detail_model.dart';
import 'package:job_finder/features/profile/domain/entity/userDetail_entity.dart';

final userDetailsRemoteDataSourceProvider =
    Provider.autoDispose<UserDetailsRemoteDataSource>(
  (ref) => UserDetailsRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class UserDetailsRemoteDataSource {
  final Dio dio;
  UserDetailsRemoteDataSource({required this.dio});

  Future<Either<Failure, String>> updateUserDetails(
      String userId, UserDetailEntity userEntity) async {
    try {
      UserDetailAPIModel userDetailAPIModel =
          UserDetailAPIModel.fromEntity(userEntity);
      var response = await dio.post(ApiEndpoints.updateUsersDetils ,
          data: userDetailAPIModel.toJson());

      print("success updating the user details");

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
