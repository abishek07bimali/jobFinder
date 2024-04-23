class Failure {
  final String error;
  final String? statusCode;
  final bool? status;

  Failure({
    required this.error,
    this.statusCode,
    this.status
  });
}
