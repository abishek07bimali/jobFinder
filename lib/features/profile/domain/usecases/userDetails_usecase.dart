import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/profile/domain/entity/userDetail_entity.dart';
import 'package:job_finder/features/profile/domain/repository/userDetail_repository.dart';

final userDetailsUseCaseProvider = Provider.autoDispose<UserDetailsUseCase>(
    (ref) => UserDetailsUseCase(
        userdetailsRepository: ref.read(userDetailsRepositoryProvider),
        userSharedPrefs: ref.watch(userSharedPrefsProvider)));

class UserDetailsUseCase {
  final IUserDetailRepository userdetailsRepository;
  final UserSharedPrefs userSharedPrefs;

  UserDetailsUseCase(
      {required this.userdetailsRepository, required this.userSharedPrefs});

  Future<Either<Failure, String>> updateUserDetails(
      UserDetailEntity userDetail) async {
    final userData = await userSharedPrefs.getUser();
    String? id = userData?['_id']?.toString() ?? '';
    print("USER ID IN USRCASE::  $id");
    userDetail = userDetail.copyWith(userId: id);

    return await userdetailsRepository.updateUserDetail(id, userDetail);
  }

  Future<void> logout() async {
    await userSharedPrefs.clearAllSharedPreferences();
    ;
  }
}
