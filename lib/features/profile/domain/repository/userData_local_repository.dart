import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';
import 'package:job_finder/features/profile/data/repository/userData_remote_repo_impl.dart';

final userProfileIRepositoryProvider = Provider.autoDispose<IUserProfileRepository>(
  (ref) => ref.read(userProfileRepositoryProvider),
);

abstract class IUserProfileRepository {
  Future<Either<Failure, List<UserEntity>>> getAllUserData();
}
