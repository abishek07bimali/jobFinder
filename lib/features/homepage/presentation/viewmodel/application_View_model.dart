import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/features/homepage/domain/usecases/create_application_usecase.dart';
import 'package:job_finder/features/homepage/presentation/state/application_state.dart';

final applicationViewModelProvider =
    StateNotifierProvider<ApplicationViewModel, ApplicationState>((ref) =>
        ApplicationViewModel(ref.read(createApplicationUsecaseProvider)));

class ApplicationViewModel extends StateNotifier<ApplicationState> {
  final CreateApplicationUsecase createApplicationUsecase;

  ApplicationViewModel(this.createApplicationUsecase)
      : super(ApplicationState.initial()) {
    getApplication();
  }

  Future<void> resetState() async {
    state = ApplicationState.initial();
    getApplication();
  }

  Future<void> createApplication(String jobs) async {
    state = state.copyWith(isLoading: true);
    final result = await createApplicationUsecase.createApplication(jobs);
    state = state.copyWith(isLoading: false);

    result.fold(
      (failure) => state = state.copyWith(error: failure.error),
      (success) {
        state = state.copyWith(
            isLoading: false, showMessage: true, message: success);
      },
    );

    // resetMessage();
  }

  Future<void> getApplication() async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await createApplicationUsecase.fetchApplications();
      result.fold(
        (failure) {
          state = state.copyWith(isLoading: false);
          print("Error fetching data: $failure");
        },
        (success) {
          state = state.copyWith(isLoading: false, application: success);
          print("Data in viewModel of application list: $success");
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print("Error fetching data: $e");
    }
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
