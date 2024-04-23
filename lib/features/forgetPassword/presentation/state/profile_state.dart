import 'package:job_finder/features/forgetPassword/domain/entity/forgetPassword_entity.dart';

class ForgetpasswordState {
  final bool isLoading;
  final List<ForgetPasswordEntiry>? user;
    final bool? showMessage;
      final String? message;
        final String? error;




  ForgetpasswordState({
    required this.isLoading,
    required this.user,
     this.message,
    this.showMessage,
        this.error,

  });

  factory ForgetpasswordState.initial() {
    return ForgetpasswordState(
      isLoading: false,
      user: [],
            showMessage: false,
                  error: null,


    );
  }

  ForgetpasswordState copyWith({
    bool? isLoading,
    List<ForgetPasswordEntiry>? user,
        String? message,
    bool? showMessage,
        String? error,

  }) {
    return ForgetpasswordState(
      isLoading: isLoading ?? this.isLoading,
      user: user?? this.user,
        message: message ?? this.message,
      showMessage: showMessage ?? this.showMessage,
            error: error ?? this.error,

    );
  }
}
