import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/homepage/data/data_source/local/user_local_data_source.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';
import 'package:job_finder/features/homepage/domain/repository/jobs_repository.dart';

final jobsLocalRepositoryProvider = Provider.autoDispose<IJobsRepository>(
  (ref) => JobsLocalRepoImpl(
    jobsLocalDataSource: ref.read(jobsLocalDatSourceProvider),
  ),
);

class JobsLocalRepoImpl implements IJobsRepository {
  final JobsLocalDataSource jobsLocalDataSource;

  JobsLocalRepoImpl({required this.jobsLocalDataSource});

  @override
  Future<Either<Failure, List<JobsEntity>>> getAllJobs(int page,String userId) {
    return jobsLocalDataSource.getAllJobs(page);
  }

  @override
  Future<Either<Failure, bool>> createJobs(JobsEntity jobs) {
    print("local repo");
    return jobsLocalDataSource.createJobs(jobs);
  }
  
  @override
  Future<Either<Failure, List<JobsEntity>>> getAllRecommended(String uderId) {
    // TODO: implement getAllRecommended
    throw UnimplementedError();
  }
}
