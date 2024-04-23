import 'package:job_finder/features/auth/presentation/view/login_screen_view.dart';
import 'package:job_finder/features/auth/presentation/view/register_screen_view.dart';
import 'package:job_finder/features/favorite/presentation/view/favorite_view.dart';
import 'package:job_finder/features/forgetPassword/presentation/view/change_password_view.dart';
import 'package:job_finder/features/forgetPassword/presentation/view/forget_password_view.dart';
import 'package:job_finder/features/forgetPassword/presentation/view/new_password_view.dart';
import 'package:job_finder/features/homepage/presentation/view/homepage_view.dart';
import 'package:job_finder/features/homepage/presentation/view/navigation_view.dart';
import 'package:job_finder/features/profile/presentation/view/edit_Profile_view.dart';
import 'package:job_finder/features/profile/presentation/view/multi_view.dart';
import 'package:job_finder/features/profile/presentation/view/profile_view.dart';
import 'package:job_finder/features/profile/presentation/view/user_detail_view.dart';
import 'package:job_finder/features/splash/presentation/view/splash_screen_view.dart';

class AppRoute {
  AppRoute._();

  static const String loginRoute = "/";
  static const String splashRoute = "/splash";
  static const String registerRoute = "/register";
  static const String userDetailInputRoute = "/userdetailinput";
  static const String multiStepForm = "/multistepform";
  static const String navigationRoute = "/navigation";
  static const String homepageRoute = "/homepage";
  static const String userprofileRoute = "/profile";
  static const String individualJobRoute = "/individualjob";
  static const String favoriteJobsJobRoute = "/favoritejob";
  static const String updateProfileRoute = "/updatejob";
  static const String forgetPassword = "/forgetaPassword";
  static const String resetPassword = "/resetPassword";
  static const String changePassword = "/changePassword";

  static getApplicationRoutes() {
    return {
      splashRoute: (context) => SplashScreen(),
      loginRoute: (context) => LoginScreenView(),
      registerRoute: (context) => RegisterScreenView(),
      userDetailInputRoute: (context) => UserDetailInputView(),
      multiStepForm: (context) => MultiStepForm(),
      navigationRoute: (context) => NavigationView(),
      homepageRoute: (context) => HomepageView(),
      userprofileRoute: (context) => UserProfileView(),
      // individualJobRoute: (context) => IndividualJob(),
      favoriteJobsJobRoute: (context) => FavoriteJobsPage(),
      updateProfileRoute: (context) => EditProfileView(),
      forgetPassword: (context) => EmailVerificationPage(),
      resetPassword: (context) => ChangePasswordView(),
      changePassword: (context) => ChangePasswordByUserView(),
    };
  }
}
