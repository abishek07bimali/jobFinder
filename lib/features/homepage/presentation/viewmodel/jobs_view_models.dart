import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/provider/is_network_provider.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/homepage/data/data_source/local/user_local_data_source.dart';
import 'package:job_finder/features/homepage/data/data_source/remote/jobs_remote_data_source.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';
import 'package:job_finder/features/homepage/domain/usecases/add_jobs_usecase.dart';
import 'package:job_finder/features/homepage/presentation/state/all_Jobs_state.dart';

final jobsViewModelProvider =
    StateNotifierProvider<JobsViewModel, JobsState>((ref) {
  final jobsDataSource = ref.read(jobsRemoteDataSourceProvider);
  final addJobsUsecase = ref.read(addJobsUsecaseProvider);
  final jobsLocalDataSource = ref.read(jobsLocalDatSourceProvider);
  final connectivityStatus = ref.watch(connectivityStatusProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  return JobsViewModel(jobsDataSource, addJobsUsecase, jobsLocalDataSource,
      connectivityStatus, userSharedPrefs);
});

class JobsViewModel extends StateNotifier<JobsState> {
  final JobsRemoteDataSource _jobsDataSource;
  final AddJobsUsecase addJobsUsecase;
  final JobsLocalDataSource jobsLocalDataSource;
  final ConnectivityStatus connectivityStatus;
  final UserSharedPrefs userSharedPrefs;

  JobsViewModel(this._jobsDataSource, this.addJobsUsecase,
      this.jobsLocalDataSource, this.connectivityStatus, this.userSharedPrefs)
      : super(JobsState.initial()) {
    // getRecommended();
    getJobs();
  }

  Future<void> resetState() async {
    state = JobsState.initial();
    // getRecommended();
    getJobs();
  }

  Future<void> getJobs() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    // final jobs = currentState.jobs;
    final hasReachedMax = currentState.hasReachedMax;

    try {
      if (connectivityStatus == ConnectivityStatus.isConnected) {
        final userData = await userSharedPrefs.getUser();
        String? id = userData?['_id']?.toString() ?? '';
        if (!hasReachedMax) {
          final result = await _jobsDataSource.getAllJobs(page, id);
          result.fold(
            (failure) => handleFailure(failure),
            (data) => handleSuccess(data, page),
          );
        }
      } else {
        if (!hasReachedMax) {
          final result = await jobsLocalDataSource.getAllJobs(page);
          result.fold(
            (failure) => handleFailure(failure),
            (data) => handleSuccessLocal(data, page),
          );
        }
      }
    } catch (e) {
      print('Error fetching jobs: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  void handleFailure(Failure failure) {
    state = state.copyWith(
      hasReachedMax: true,
      isLoading: false,
    );
  }

  void handleSuccess(List<JobsEntity> data, int page) {
    if (data.isEmpty) {
      state = state.copyWith(hasReachedMax: true);
    } else {
      state = state.copyWith(
        jobs: [...state.jobs, ...data],
        page: page,
        isLoading: false,
      );
      if (connectivityStatus == ConnectivityStatus.isConnected) {
        _saveJobsToLocal(data);
      }
    }
  }

  void handleSuccessLocal(List<JobsEntity> data, int page) {
    if (data.isEmpty) {
      state = state.copyWith(hasReachedMax: true);
    } else {
      state = state.copyWith(
        jobs: data,
        page: page,
        isLoading: false,
      );
      if (connectivityStatus == ConnectivityStatus.isConnected) {
        _saveJobsToLocal(data);
      }
    }
  }

  Future<void> _saveJobsToLocal(List<JobsEntity> jobs) async {
    state = state.copyWith(isLoading: true);
    try {
      for (var job in jobs) {
        final result = await addJobsUsecase.addJobs(job);
        result.fold(
          (failure) {
            state = state.copyWith(isLoading: false);
          },
          (success) {
            state = state.copyWith(isLoading: false);
          },
        );
      }
    } catch (e) {
      print('Error saving jobs to local database: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
