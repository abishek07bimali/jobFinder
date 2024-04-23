import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/homepage/data/repository/jobs_remote_repo_impl.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';

final jobsRepositoryProvider = Provider.autoDispose<IJobsRepository>(
  (ref) => ref.read(jobsRemoteRepositoryProvider),
);

abstract class IJobsRepository {
  Future<Either<Failure, bool>> createJobs(JobsEntity jobs);
  Future<Either<Failure, List<JobsEntity>>> getAllJobs(int page, String userId);
  Future<Either<Failure, List<JobsEntity>>> getAllRecommended(String  id);
}
