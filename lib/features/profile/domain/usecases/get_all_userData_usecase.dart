import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';
import 'package:job_finder/features/profile/domain/repository/userData_local_repository.dart';

final getAllUserDataUsecaseProvider =
    Provider.autoDispose<GetAllUserDataUsecase>((ref) => GetAllUserDataUsecase(
        sharedPrefs: ref.read(userSharedPrefsProvider),
        userProfileRepository: ref.read(userProfileIRepositoryProvider)));

class GetAllUserDataUsecase {
  final UserSharedPrefs sharedPrefs;
  final IUserProfileRepository userProfileRepository;

  GetAllUserDataUsecase({
    required this.sharedPrefs,
    required this.userProfileRepository,
  });


Future<List<UserEntity>> getAllUserData() async {
  try {
    final userData = await userProfileRepository.getAllUserData();
    return userData.fold(
      (failure) {
        print('Error getting user data: $failure');
        // Throw an exception or handle the failure case accordingly
        throw Exception('Error getting user data: $failure');
      },
      (userList) => userList,
    );
  } catch (e) {
    print('Error getting user data: $e');
    throw Exception('Error getting user data: $e');
  }
}



}
