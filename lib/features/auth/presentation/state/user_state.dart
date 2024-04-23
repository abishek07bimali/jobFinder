class UserState {
  final bool isLoading;
  final String? error;
  final String? message;
  final bool? showMessage;
  final bool? status;

  UserState({
    required this.isLoading,
    this.error,
    this.message,
    this.showMessage = false,
    this.status = false,
  });

  factory UserState.initialState() => UserState(
      isLoading: false,
      showMessage: false,
      message: null,
      status: null,
      error: null);

  UserState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    bool? status,
    String? message,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      message: message,
      showMessage: showMessage ?? this.showMessage,
      status: status,
    );
  }

  @override
  String toString() =>
      'AuthState(isLoading: $isLoading, error: $error,message:$message, showMessage:$showMessage, status:$status)';
}
