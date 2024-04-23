import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/features/homepage/domain/usecases/comment_usecase%20.dart';
import 'package:job_finder/features/homepage/presentation/state/comment_state.dart';

final commentViewModelProvider =
StateNotifierProvider<CommentViewModel, CommentState>((ref) =>
    CommentViewModel(ref.read(commentUsecaseProvider)));

class CommentViewModel extends StateNotifier<CommentState> {
  final CommentUsecase commentUsecase;

  CommentViewModel(this.commentUsecase)
      : super(CommentState.initial()) {
    // getComments();
  }

  Future<void> resetState() async {
    state = CommentState.initial();
    // getApplication();
  }

  Future<void> createComment(String jobs,String comment) async {
    state = state.copyWith(isLoading: true);
    final result = await commentUsecase.createComment(jobs,comment);
    state = state.copyWith(isLoading: false);

    result.fold(
          (failure) => state = state.copyWith(error: failure.error),
          (success) {
        getComments(jobs);
        state = state.copyWith(
            isLoading: false, showMessage: true, message: success);
      },
    );

    // resetMessage();
  }

  Future<void> getComments(String jobId) async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await commentUsecase.fetchComment(jobId);
      result.fold(
            (failure) {
          state = state.copyWith(isLoading: false);
          print("Error fetching data: $failure");
        },
            (success) {
          state = state.copyWith(isLoading: false, comment: success);
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
