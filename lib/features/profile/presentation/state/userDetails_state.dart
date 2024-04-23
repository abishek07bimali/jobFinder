class UserDetailState {
  final bool isLoading;
  final String? error;
  final String? message;
  final bool? showMessage;

  UserDetailState({
    required this.isLoading,
    this.error,
    this.message,
    this.showMessage,
  });

  factory UserDetailState.initial() {
    return UserDetailState(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }

  UserDetailState copyWith({
    bool? isLoading,
    String? error,
    String? message,
    bool? showMessage,
  }) {
    return UserDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      message: message ?? this.message,
      showMessage: showMessage ?? this.showMessage,
    );
  }

  @override
  String toString() => 'UserDetailState(isLoading: $isLoading, error: $error, message: $message)';
}
