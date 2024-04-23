import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/routes/app_routes.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/snackbar/snackbar.dart';
import 'package:job_finder/features/forgetPassword/domain/entity/change_password_entity.dart';
import 'package:job_finder/features/forgetPassword/domain/usecases/changePassword_usecase.dart';
import 'package:job_finder/features/forgetPassword/presentation/state/changePassword_state.dart';

final changePasswordViewModelProvider =
    StateNotifierProvider<ChangePasswordViewModel, ChangepasswordState>((ref) =>
        ChangePasswordViewModel(ref.read(changePasswordUseCaseProvider)));

class ChangePasswordViewModel extends StateNotifier<ChangepasswordState> {
  final ChangepasswordUseCase changepasswordUseCase;

  ChangePasswordViewModel(this.changepasswordUseCase)
      : super(ChangepasswordState.initial());

  Future<void> changePassword(
    BuildContext context,
    ChangePasswordEntity entity,
  ) async {
    state = state.copyWith(isLoading: true);
    final result = await changepasswordUseCase.changePassword(entity);
    state = state.copyWith(isLoading: false);

    result.fold((failure) {
      state = state.copyWith(error: failure.error);
      showMySnackBar(message: failure.error, context: context, color: appRed);
    }, (success) {
      state =
          state.copyWith(isLoading: false, showMessage: true, message: success);
      showMySnackBar(message: success, context: context);
      Navigator.pushReplacementNamed(context, AppRoute.navigationRoute);
    });
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
