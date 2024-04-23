import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/snackbar/snackbar.dart';
import 'package:job_finder/features/homepage/domain/entity/favorite_entity.dart';
import 'package:job_finder/features/homepage/domain/usecases/favorite_usecase.dart';
import 'package:job_finder/features/homepage/presentation/state/favorite_state.dart';

final favoriteViewModelProvider =
    StateNotifierProvider<FavoriteViewModel, AddFavoriteState>(
        (ref) => FavoriteViewModel(ref.read(favoriteUseCaseProvider)));

class FavoriteViewModel extends StateNotifier<AddFavoriteState> {
  final FavoriteUseCase _favoriteUseCase;

  FavoriteViewModel(this._favoriteUseCase) : super(AddFavoriteState.initial());

  Future<void> createFavorite(
      FavoriteEntiry entity, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final result = await _favoriteUseCase.createFavorite(entity);
    state = state.copyWith(isLoading: false);

    result.fold((failure) => state = state.copyWith(error: failure.error),
        (success) {
      state =
          state.copyWith(isLoading: false, showMessage: true, message: success);
      showMySnackBar(message: success, context: context);
    });

    // resetMessage();
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
