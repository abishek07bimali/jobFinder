import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/forgetPassword/domain/entity/change_password_entity.dart';
import 'package:job_finder/features/forgetPassword/domain/repository/change_password_repository.dart';

final changePasswordUseCaseProvider =
    Provider.autoDispose<ChangepasswordUseCase>((ref) => ChangepasswordUseCase(
        iUserChangePasswordRepository:
            ref.read(changePasswordRepositoryProvider),
        userSharedPrefs: ref.watch(userSharedPrefsProvider)));

class ChangepasswordUseCase {
  final IUserChangePasswordRepository iUserChangePasswordRepository;
  final UserSharedPrefs userSharedPrefs;

  ChangepasswordUseCase(
      {required this.iUserChangePasswordRepository,
      required this.userSharedPrefs});

  Future<Either<Failure, String>> changePassword(
      ChangePasswordEntity changePasswordEntiry) async {
    final userData = await userSharedPrefs.getUser();
    String? id = userData?['_id']?.toString() ?? '';
    changePasswordEntiry = changePasswordEntiry.copyWith(userId: id);

    return await iUserChangePasswordRepository
        .changePassword(changePasswordEntiry);
  }
}
