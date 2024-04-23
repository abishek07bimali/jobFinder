import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';
import 'package:job_finder/features/homepage/domain/repository/jobs_repository.dart';


final addJobsUsecaseProvider = Provider.autoDispose<AddJobsUsecase>(
  (ref) => AddJobsUsecase(repository: ref.watch(jobsRepositoryProvider)),
);

class AddJobsUsecase {
  final IJobsRepository repository;

  AddJobsUsecase({required this.repository});

  Future<Either<Failure, bool>> addJobs(JobsEntity jobs) async {
    return await repository.createJobs(jobs);
  }
}
