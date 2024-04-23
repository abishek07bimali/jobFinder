import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/features/homepage/domain/usecases/get_all_jobs_usecase.dart';
import 'package:job_finder/features/homepage/presentation/state/all_Jobs_state.dart';

final recommendedJobsViewModelProvider =
    StateNotifierProvider<RecommendedJobsViewModel, JobsState>((ref) {
  final getAllJobsUsecase = ref.read(getAllJobsUsecaseProvider);
  return RecommendedJobsViewModel(
    getAllJobsUsecase,
  );
});

class RecommendedJobsViewModel extends StateNotifier<JobsState> {
  final GetAllJobsUsecase getAllJobsUsecase;

  RecommendedJobsViewModel(this.getAllJobsUsecase) : super(JobsState.initial()) {
    getRecommended();
  }

  Future<void> resetState() async {
    state = JobsState.initial();
    getRecommended();
  }

  Future<void> getRecommended() async {
    state = state.copyWith(isLoading: true);
    getAllJobsUsecase.getAllRecommended().then((value) => value.fold(
          (l) {
            state = state.copyWith(isLoading: false);
            print("Error fetching data: $l");
          },
          (r) {
            state = state.copyWith(isLoading: false, jobs: r);
            print("Data in viewModel of favorite list:: $r");
          },
        ));
  }
}
