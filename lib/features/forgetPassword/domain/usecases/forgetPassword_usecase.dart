import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/forgetPassword/domain/entity/forgetPassword_entity.dart';
import 'package:job_finder/features/forgetPassword/domain/repository/forget_password_repository.dart';

final forgetPasswordUseCaseProvider = Provider.autoDispose<ForgetPasswordUseCase>(
    (ref) => ForgetPasswordUseCase(
        iforgetPasswordrepository: ref.read(forgetPasswordRepositoryProvider),));

class ForgetPasswordUseCase {
  final IUserForgetPasswordRepository iforgetPasswordrepository;

  ForgetPasswordUseCase(
      {required this.iforgetPasswordrepository});

  Future<Either<Failure, String>> forgetPassword(
      ForgetPasswordEntiry forgetPasswordEntiry) async {
    return await iforgetPasswordrepository.forgetPassword(forgetPasswordEntiry);
  }

  Future<Either<Failure, String>> verifyOTP(
      ForgetPasswordEntiry forgetPasswordEntiry) async {
    return await iforgetPasswordrepository.verifyOTP(forgetPasswordEntiry);
  }
  Future<Either<Failure, String>> resetPassword(
      ForgetPasswordEntiry forgetPasswordEntiry) async {
    return await iforgetPasswordrepository.resetpassword(forgetPasswordEntiry);
  }
}
