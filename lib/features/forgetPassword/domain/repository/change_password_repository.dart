import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/forgetPassword/data/repository/change_password_remote_repo_impl%20.dart';
import 'package:job_finder/features/forgetPassword/domain/entity/change_password_entity.dart';

final changePasswordRepositoryProvider = Provider.autoDispose<IUserChangePasswordRepository>(
  (ref) => ref.read(changePasswordRemoteRepositoryProvider),
);

abstract class IUserChangePasswordRepository {
  Future<Either<Failure, String>> changePassword(ChangePasswordEntity changePasswordEntiry);

}
