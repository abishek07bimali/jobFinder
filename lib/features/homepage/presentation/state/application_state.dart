import 'package:job_finder/features/homepage/domain/entity/application_entiry.dart';

class ApplicationState {
  final bool isLoading;
  final String? error;
  final bool? showMessage;
  final String? message;
  final List<ApplicationEntity> application;

  ApplicationState(
      {required this.isLoading,
      this.error,
      this.showMessage,
      this.message,
      required this.application});

  factory ApplicationState.initial() {
    return ApplicationState(
        isLoading: false, error: null, showMessage: false, application: []);
  }

  ApplicationState copyWith(
      {final List<ApplicationEntity>? application,
      bool? isLoading,
      String? error,
      bool? showMessage,
      String? message}) {
    return ApplicationState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        application: application ?? this.application,
        message: message ?? this.message);
  }

  @override
  String toString() => 'ApplicationState(isLoading: $isLoading, error: $error)';
}
