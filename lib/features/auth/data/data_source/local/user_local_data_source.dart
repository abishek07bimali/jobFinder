import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/networking/hive_service.dart';
import 'package:job_finder/features/auth/data/model/user_hive_model.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';

final userLocalDatSourceProvider = Provider.autoDispose<UserLocalDataSource>(
  (ref) => UserLocalDataSource(hiveService: ref.read(hiveServiceProvider)),
);

class UserLocalDataSource {
  final HiveService hiveService;

  UserLocalDataSource({required this.hiveService});

  // Add user
  Future<Either<Failure, String>> createUser(UserEntity user) async {
    try {
      UserHiveModel userHiveModel = UserHiveModel.toHiveModel(user);
      hiveService.createUser(userHiveModel);
      return const Right("true");
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
