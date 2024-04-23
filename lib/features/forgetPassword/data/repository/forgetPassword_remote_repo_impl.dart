import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/forgetPassword/data/data_source/forgetPassword_remote_data_source.dart';
import 'package:job_finder/features/forgetPassword/domain/entity/forgetPassword_entity.dart';
import 'package:job_finder/features/forgetPassword/domain/repository/forget_password_repository.dart';

final forgetPasswordRemoteRepositoryProvider =
    Provider.autoDispose<IUserForgetPasswordRepository>(
  (ref) => ForgetpasswordRepoImpl(
    forgetPasswordRemoteDataSource: ref.read(forgetPasswordRemoteDataSourceProvider),
  ),
);


class ForgetpasswordRepoImpl extends IUserForgetPasswordRepository {
  final ForgetPasswordRemoteDataSource forgetPasswordRemoteDataSource;

  ForgetpasswordRepoImpl({required this.forgetPasswordRemoteDataSource});

  // @override
  // Future<Either<Failure, String>> updateUserDetail(
  //     String id, UserDetailEntity favorite) async {
  //   final result =
  //       await userDetailsRemoteDataSource.updateUserDetails(id, favorite);
  //   return result.fold((failure) => Left(failure), (success) => Right(success));
  // }

  @override
  Future<Either<Failure, String>> forgetPassword( ForgetPasswordEntiry forgetPasswordEntiry) async {
    final result =
        await forgetPasswordRemoteDataSource.forgetPassword(forgetPasswordEntiry);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
  @override
  Future<Either<Failure, String>> verifyOTP( ForgetPasswordEntiry forgetPasswordEntiry) async {
    final result =
        await forgetPasswordRemoteDataSource.verifyOTP(forgetPasswordEntiry);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
  @override
  Future<Either<Failure, String>> resetpassword( ForgetPasswordEntiry forgetPasswordEntiry) async {
    final result =
        await forgetPasswordRemoteDataSource.changePassword(forgetPasswordEntiry);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
}
