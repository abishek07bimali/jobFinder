import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/auth/data/data_source/local/user_local_data_source.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';
import 'package:job_finder/features/auth/domain/repository/user_repository.dart';

final iuserLocalRepositoryImpl = Provider.autoDispose<IUserRepository>(
  (ref) => UserLocalRepositoryImpl(
      userLocalDataSource: ref.read(userLocalDatSourceProvider)),
);

class UserLocalRepositoryImpl implements IUserRepository {
  final UserLocalDataSource userLocalDataSource;

  UserLocalRepositoryImpl({
    required this.userLocalDataSource,
  });

  @override
  Future<Either<Failure, String>> createUser(UserEntity user) async {
    final result = await userLocalDataSource.createUser(user);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, String>> loginUser(String email, String password) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> updateUser(
      String id, UserEntity userEntity, File? image) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
