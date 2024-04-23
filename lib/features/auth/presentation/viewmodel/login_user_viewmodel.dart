import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/routes/app_routes.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/snackbar/snackbar.dart';
import 'package:job_finder/features/auth/domain/usecases/login_usecase.dart';
import 'package:job_finder/features/auth/presentation/state/user_state.dart';

final userLoginViewModelProvider =
    StateNotifierProvider<UserLoginViewModel, UserState>(
  (ref) => UserLoginViewModel(
    ref.read(loginUseCaseProvider),
  ),
);

class UserLoginViewModel extends StateNotifier<UserState> {
  final LoginUseCase _loginUseCase;

  UserLoginViewModel(
    this._loginUseCase,
  ) : super(UserState.initialState());

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    state = state.copyWith(isLoading: true);
    final result = await _loginUseCase.loginUser(email, password);
    state = state.copyWith(isLoading: false);
    // print(result);

    result.fold(
      (failure) {
        state = state.copyWith(
            error: null,
            showMessage: true,
            message: failure.error,
            isLoading: false,
            status: failure.status);
        showMySnackBar(message: failure.error, context: context, color: appRed);
      },
      (success) {
        state = state.copyWith(
            isLoading: false, showMessage: true, error: null, message: success);
        Navigator.popAndPushNamed(context, AppRoute.navigationRoute);
        showMySnackBar(message: success, context: context, color: appCOlor);
      },
    );
  }

  // void reset() {
  //   state = state.copyWith(
  //       isLoading: false,
  //       error: null,
  //       // imageName: null,
  //       showMessage: false,
  //       message: null);
  // }

  void resetMessage() {
    state = state.copyWith(
        showMessage: false,
        error: null,
        message: null,
        status: false,
        isLoading: false);
  }
}
