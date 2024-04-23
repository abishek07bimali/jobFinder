import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/snackbar/snackbar.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';
import 'package:job_finder/features/auth/domain/usecases/add_user_case.dart';
import 'package:job_finder/features/auth/presentation/state/user_state.dart';

final userViewModelProvider = StateNotifierProvider<UserViewModel, UserState>(
  (ref) => UserViewModel(
    ref.read(addUseruseCase),
    // ref.read(loginUseCaseProvider),
  ),
);

class UserViewModel extends StateNotifier<UserState> {
  final AddUseruseCase addUserUseCase;
  // final LoginUseCase _loginUseCase;

  UserViewModel(
    this.addUserUseCase,
    // this._loginUseCase,
  ) : super(UserState.initialState());

  void addUser(BuildContext context, UserEntity user) {
    state = state.copyWith(isLoading: true);
    addUserUseCase.createUser(user).then((value) {
      value.fold(
        (failure) {
          state = state.copyWith(
              error: null,
              showMessage: true,
              message: failure.error,
              isLoading: false,
              status: failure.status);
          showMySnackBar(
              message: failure.error, context: context, color: appRed);
        },
        (success) {
          state = state.copyWith(
            isLoading: false,
            showMessage: true,
            error: null,
            message: success,
          );
          showMySnackBar(message: success, context: context, color: appCOlor);
        },
      );
    });
  }

  void updateUser(BuildContext context, UserEntity user,File? image) {
    state = state.copyWith(isLoading: true);
    addUserUseCase.updateUser(user,image).then((value) {
      value.fold(
        (failure) {
          state = state.copyWith(
              error: null,
              showMessage: true,
              message: failure.error,
              isLoading: false,
              status: failure.status);
          showMySnackBar(
              message: failure.error, context: context, color: appRed);
        },
        (success) {
          state = state.copyWith(
            isLoading: false,
            showMessage: true,
            error: null,
            message: success,
          );
          showMySnackBar(message: success, context: context, color: appCOlor);
          Navigator.pop(context);
        },
      );
    });
  }

  void resetMessage() {
    state = state.copyWith(
        showMessage: false,
        error: null,
        message: null,
        status: false,
        isLoading: false);
  }
}
