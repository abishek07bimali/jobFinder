import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/homepage/data/data_source/local/user_local_data_source.dart';
import 'package:job_finder/features/homepage/data/data_source/remote/jobs_remote_data_source.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';
import 'package:job_finder/features/homepage/domain/repository/jobs_repository.dart';

final jobsRemoteRepositoryProvider = Provider.autoDispose<IJobsRepository>(
  (ref) => JobsRemoteRepoImpl(
    jobsRemoteDataSource: ref.read(jobsRemoteDataSourceProvider),
    jobslocalDataSource: ref.read(jobsLocalDatSourceProvider),
  ),
);

class JobsRemoteRepoImpl implements IJobsRepository {
  final JobsRemoteDataSource jobsRemoteDataSource;
  final JobsLocalDataSource jobslocalDataSource;

  JobsRemoteRepoImpl(
      {required this.jobsRemoteDataSource, required this.jobslocalDataSource});

  @override
  Future<Either<Failure, List<JobsEntity>>> getAllJobs(int page,String userId) {
    return jobsRemoteDataSource.getAllJobs(page, userId);
  }
  @override
  Future<Either<Failure, List<JobsEntity>>> getAllRecommended(String userId) {
    return jobsRemoteDataSource.getAllRecommended(userId);
  }

  @override
  Future<Either<Failure, bool>> createJobs(JobsEntity jobs) {
    // print("IMPL REMOTE:::");
    return jobslocalDataSource.createJobs(jobs);
  }
}
