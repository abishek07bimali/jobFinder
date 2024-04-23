import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';

class JobsState {
  final List<JobsEntity> jobs;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;

  JobsState({
    required this.jobs,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
  });

  factory JobsState.initial() {
    return JobsState(
      jobs: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
    );
  }

  JobsState copyWith({
    List<JobsEntity>? jobs,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
  }) {
    return JobsState(
      jobs: jobs ?? this.jobs,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
