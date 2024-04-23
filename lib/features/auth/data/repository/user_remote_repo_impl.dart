import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/auth/data/data_source/remote/user_remote_data_source.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';
import 'package:job_finder/features/auth/domain/repository/user_repository.dart';

final userRemoteRepositoryProvider = Provider.autoDispose<IUserRepository>(
  (ref) => UserRemoteRepoImpl(
    userRemoteDataSource: ref.read(userRemoteDataSourceProvider),
  ),
);

class UserRemoteRepoImpl implements IUserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRemoteRepoImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, String>> createUser(UserEntity user) async {
    final result = await userRemoteDataSource.adduser(user);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    final result = await userRemoteDataSource.loginUser(email, password);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
  
  @override
  Future<Either<Failure, String>> updateUser(String id, UserEntity userEntity,File? image) async {
     final result = await userRemoteDataSource.updateUser(id,userEntity,image);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
}
