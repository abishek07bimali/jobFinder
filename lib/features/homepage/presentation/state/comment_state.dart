
import 'package:job_finder/features/homepage/domain/entity/comment_entity.dart';

class CommentState {
  final bool isLoading;
  final String? error;
  final bool? showMessage;
  final String? message;
  final List<CommentEntity> comment;

  CommentState(
      {required this.isLoading,
      this.error,
      this.showMessage,
      this.message,
      required this.comment});

  factory CommentState.initial() {
    return CommentState(
        isLoading: false, error: null, showMessage: false, comment: []);
  }

  CommentState copyWith(
      {final List<CommentEntity>? comment,
      bool? isLoading,
      String? error,
      bool? showMessage,
      String? message}) {
    return CommentState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        comment: comment ?? this.comment,
        message: message ?? this.message);
  }

  @override
  String toString() => 'CommentState(isLoading: $isLoading, error: $error)';
}
