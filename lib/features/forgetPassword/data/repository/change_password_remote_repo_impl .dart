import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/forgetPassword/data/data_source/change_password_remote_data_source%20.dart';
import 'package:job_finder/features/forgetPassword/domain/entity/change_password_entity.dart';
import 'package:job_finder/features/forgetPassword/domain/repository/change_password_repository.dart';

final changePasswordRemoteRepositoryProvider =
    Provider.autoDispose<IUserChangePasswordRepository>(
  (ref) => ChangepasswordRepoImpl(
    changePasswordRemoteDataSource: ref.read(changePasswordRemoteDataSourceProvider),
  ),
);


class ChangepasswordRepoImpl extends IUserChangePasswordRepository {
  final ChangePasswordRemoteDataSource changePasswordRemoteDataSource;

  ChangepasswordRepoImpl({required this.changePasswordRemoteDataSource});

  @override
  Future<Either<Failure, String>> changePassword( ChangePasswordEntity changePasswordEntiry) async {
    final result =
        await changePasswordRemoteDataSource.changePassword(changePasswordEntiry);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
}
