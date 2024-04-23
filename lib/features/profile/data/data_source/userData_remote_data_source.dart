import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/networking/http_service.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';

final userDataProfileRemoteDataSourceProvider =
    Provider.autoDispose<UserProfileDataLocalDataSource>(
  (ref) => UserProfileDataLocalDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class UserProfileDataLocalDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  UserProfileDataLocalDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Map<String, dynamic>?> getAllFavorite() async {
    try {
      final userData = await userSharedPrefs.getUser();
      return userData;
    } catch (e) {
      // Handle exceptions
      print("Error while retrieving user data: $e");
      return null;
    }
  }
}
