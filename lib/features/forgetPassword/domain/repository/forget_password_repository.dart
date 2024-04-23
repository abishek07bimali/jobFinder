import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/forgetPassword/data/repository/forgetPassword_remote_repo_impl.dart';
import 'package:job_finder/features/forgetPassword/domain/entity/forgetPassword_entity.dart';

final forgetPasswordRepositoryProvider = Provider.autoDispose<IUserForgetPasswordRepository>(
  (ref) => ref.read(forgetPasswordRemoteRepositoryProvider),
);

abstract class IUserForgetPasswordRepository {
  Future<Either<Failure, String>> forgetPassword(ForgetPasswordEntiry forgetPasswordEntiry);
  Future<Either<Failure, String>> verifyOTP(ForgetPasswordEntiry forgetPasswordEntiry);
  Future<Either<Failure, String>> resetpassword(ForgetPasswordEntiry forgetPasswordEntiry);
}
