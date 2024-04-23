import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/routes/app_routes.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/snackbar/snackbar.dart';
import 'package:job_finder/features/profile/domain/entity/userDetail_entity.dart';
import 'package:job_finder/features/profile/domain/usecases/userDetails_usecase.dart';
import 'package:job_finder/features/profile/presentation/state/userDetails_state.dart';

final userDetailViewModelProvider =
    StateNotifierProvider<UserDetailViewModel, UserDetailState>(
        (ref) => UserDetailViewModel(ref.read(userDetailsUseCaseProvider)));

class UserDetailViewModel extends StateNotifier<UserDetailState> {
  final UserDetailsUseCase userDetailsUseCase;

  UserDetailViewModel(this.userDetailsUseCase)
      : super(UserDetailState.initial());

  Future<void> updateUserDetails(
      BuildContext context, UserDetailEntity entity) async {
    state = state.copyWith(isLoading: true);
    final result = await userDetailsUseCase.updateUserDetails(entity);
    state = state.copyWith(isLoading: false);

    result.fold((failure) {
      state = state.copyWith(error: failure.error);
      showMySnackBar(message: failure.error, context: context, color: appRed);
    }, (success) {
      state =
          state.copyWith(isLoading: false, showMessage: true, message: success);
      showMySnackBar(message: success, context: context);
      Navigator.pop(context);
    });
  }

  Future<void> logOut(BuildContext context) async {
    await userDetailsUseCase.logout();
    Navigator.pushNamed(context, AppRoute.loginRoute);
    showMySnackBar(message: "See You Soon", context: context);
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
