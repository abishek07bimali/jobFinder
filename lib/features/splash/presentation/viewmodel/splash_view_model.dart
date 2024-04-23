import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/routes/app_routes.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';


final splashViewModelProvider = StateNotifierProvider<SplashViewModel, void>(
  (ref) {
    return SplashViewModel(
      ref.read(userSharedPrefsProvider),
    );
  },
);

class SplashViewModel extends StateNotifier<void> {
  final UserSharedPrefs _userSharedPrefs;
  SplashViewModel(this._userSharedPrefs) : super(null);

  init(BuildContext context) async {
    final data = await _userSharedPrefs.getUserToken();

    data.fold((l) => null, (token) {
      if (token != null) {
        Navigator.popAndPushNamed(context, AppRoute.navigationRoute);
      } else {
        Navigator.popAndPushNamed(context, AppRoute.loginRoute);
      }
    });
  }
}