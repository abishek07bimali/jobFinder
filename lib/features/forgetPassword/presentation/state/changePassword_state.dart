import 'package:job_finder/features/forgetPassword/domain/entity/change_password_entity.dart';

class ChangepasswordState {
  final bool isLoading;
  final List<ChangePasswordEntity>? user;
  final bool? showMessage;
  final String? message;
  final String? error;

  ChangepasswordState({
    required this.isLoading,
    required this.user,
    this.message,
    this.showMessage,
    this.error,
  });

  factory ChangepasswordState.initial() {
    return ChangepasswordState(
      isLoading: false,
      user: [],
      showMessage: false,
      error: null,
    );
  }

  ChangepasswordState copyWith({
    bool? isLoading,
    List<ChangePasswordEntity>? user,
    String? message,
    bool? showMessage,
    String? error,
  }) {
    return ChangepasswordState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      message: message ?? this.message,
      showMessage: showMessage ?? this.showMessage,
      error: error ?? this.error,
    );
  }
}
