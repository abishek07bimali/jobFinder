import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/auth/data/repository/user_remote_repo_impl.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';

final iuserRepositoryProvider = Provider.autoDispose<IUserRepository>((ref) {
  // internet nahuda data local bata aauxa
  return ref.read(userRemoteRepositoryProvider);
});

abstract class IUserRepository {
  Future<Either<Failure, String>> createUser(UserEntity user);
  Future<Either<Failure, String>> loginUser(String email, String password);
  Future<Either<Failure, String>> updateUser(String id, UserEntity userEntity, File? image);
}
