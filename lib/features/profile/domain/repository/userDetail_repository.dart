import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/profile/data/repository/userDetail_remote_repo_impl.dart';
import 'package:job_finder/features/profile/domain/entity/userDetail_entity.dart';

final userDetailsRepositoryProvider = Provider.autoDispose<IUserDetailRepository>(
  (ref) => ref.read(userDetailsRemoteRepositoryProvider),
);

abstract class IUserDetailRepository {
  Future<Either<Failure, String>> updateUserDetail(String id,UserDetailEntity userDetailEntity);
}
