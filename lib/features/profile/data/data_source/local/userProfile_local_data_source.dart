import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/networking/http_service.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';

final userProfileDataSourceProvider =
    Provider.autoDispose<UserProfileLocalDataSource>(
  (ref) => UserProfileLocalDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.watch(userSharedPrefsProvider)),
);

class UserProfileLocalDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  UserProfileLocalDataSource(
      {required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, List<UserEntity>>> getAllUserProfileData() async {
    try {
      final userData = await userSharedPrefs.getUser();

      if (userData != null) {
        final List<UserEntity> userEntities = [];
        userData.forEach((key, value) {
          final userEntity = UserEntity.fromJson(value);
          userEntities.add(userEntity);
        });

        return Right(userEntities);
      } else {
        return Left(Failure(error: 'User data is null'));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
