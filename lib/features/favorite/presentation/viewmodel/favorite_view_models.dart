import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/features/favorite/domain/usecases/get_all_favorite_usecase.dart';
import 'package:job_finder/features/favorite/presentation/state/all_Favorite_state.dart';

final favoriteViewModelProvider =
    StateNotifierProvider<FavoriteJobsViewModel, FavoriteState>((ref) {
  final favoriteRemoteuseCase = ref.read(getAllFavoriteUsecaseProvider);
  return FavoriteJobsViewModel(favoriteRemoteuseCase);
});

class FavoriteJobsViewModel extends StateNotifier<FavoriteState> {
  final GetAllFavoriteUsecase favoriteRemoteuseCase;

  FavoriteJobsViewModel(
    this.favoriteRemoteuseCase,
  ) : super(FavoriteState.initial()) {
    getFavJobs();
  }

  Future<void> resetState() async {
    state = FavoriteState.initial();
    getFavJobs();
  }

  Future<void> getFavJobs() async {
    state = state.copyWith(isLoading: true);
    favoriteRemoteuseCase.getAllFavorite().then((value) => value.fold(
          (l) {
            state = state.copyWith(isLoading: false);
            print("Error fetching data: $l"); // Debug print statement
          },
          (r) {
            state = state.copyWith(isLoading: false, jobs: r);
            print("Data in viewModel of favorite list:: $r");
          },
        ));
  }
}
