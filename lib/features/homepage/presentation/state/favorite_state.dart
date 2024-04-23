class AddFavoriteState {
  final bool isLoading;
  final String? error;
  final String? message;
  final bool? showMessage;

  AddFavoriteState({
    required this.isLoading,
    this.error,
    this.message,
    this.showMessage,
  });

  factory AddFavoriteState.initial() {
    return AddFavoriteState(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }

  AddFavoriteState copyWith({
    bool? isLoading,
    String? error,
    String? message,
    bool? showMessage,
  }) {
    return AddFavoriteState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      message: message ?? this.message,
      showMessage: showMessage ?? this.showMessage,
    );
  }

  @override
  String toString() => 'AddFavoriteState(isLoading: $isLoading, error: $error, message: $message)';
}
