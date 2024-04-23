import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/routes/app_routes.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/snackbar/snackbar.dart';
import 'package:job_finder/features/forgetPassword/domain/entity/forgetPassword_entity.dart';
import 'package:job_finder/features/forgetPassword/domain/usecases/forgetPassword_usecase.dart';
import 'package:job_finder/features/forgetPassword/presentation/state/profile_state.dart';

final foregetPasswordViewModelProvider =
    StateNotifierProvider<ForgetpasswordVIewModel, ForgetpasswordState>((ref) =>
        ForgetpasswordVIewModel(ref.read(forgetPasswordUseCaseProvider)));

class ForgetpasswordVIewModel extends StateNotifier<ForgetpasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;

  ForgetpasswordVIewModel(this.forgetPasswordUseCase)
      : super(ForgetpasswordState.initial());

  Future<void> forgetpassword(BuildContext context, ForgetPasswordEntiry entity,
      Function() onSuccess) async {
    state = state.copyWith(isLoading: true);
    final result = await forgetPasswordUseCase.forgetPassword(entity);
    state = state.copyWith(isLoading: false);

    result.fold((failure) {
      state = state.copyWith(error: failure.error);
      showMySnackBar(message: failure.error, context: context, color: appRed);
    }, (success) {
      state =
          state.copyWith(isLoading: false, showMessage: true, message: success);
      showMySnackBar(message: success, context: context);
      onSuccess(); 
    });
  }

  Future<void> verifyOTP(
      BuildContext context, ForgetPasswordEntiry entity, String email) async {
    state = state.copyWith(isLoading: true);
    final result = await forgetPasswordUseCase.verifyOTP(entity);
    state = state.copyWith(isLoading: false);

    result.fold((failure) {
      state = state.copyWith(error: failure.error);
      showMySnackBar(message: failure.error, context: context, color: appRed);
    }, (success) {
      state =
          state.copyWith(isLoading: false, showMessage: true, message: success);
      showMySnackBar(message: success, context: context);
      Navigator.popAndPushNamed(context, AppRoute.resetPassword,
          arguments: email);
    });
  }

  Future<void> resetPassword(
      BuildContext context, ForgetPasswordEntiry entity) async {
    state = state.copyWith(isLoading: true);
    final result = await forgetPasswordUseCase.resetPassword(entity);
    state = state.copyWith(isLoading: false);

    result.fold((failure) {
      state = state.copyWith(error: failure.error);
      showMySnackBar(message: failure.error, context: context, color: appRed);
    }, (success) {
      state =
          state.copyWith(isLoading: false, showMessage: true, message: success);
      showMySnackBar(message: success, context: context);
      Navigator.popAndPushNamed(context, AppRoute.loginRoute);
    });
    reset();
  }

  void reset() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }

  void resetMessage() {
    state = state.copyWith(
        showMessage: false, error: null, message: null, isLoading: false);
  }
}
