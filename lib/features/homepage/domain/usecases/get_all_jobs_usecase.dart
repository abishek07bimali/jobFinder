import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';
import 'package:job_finder/features/homepage/domain/repository/jobs_repository.dart';

final getAllJobsUsecaseProvider = Provider.autoDispose<GetAllJobsUsecase>(
  (ref) => GetAllJobsUsecase(
      repository: ref.read(jobsRepositoryProvider),
      sharedPrefs: ref.watch(userSharedPrefsProvider)),
);

class GetAllJobsUsecase {
  final IJobsRepository repository;
  final UserSharedPrefs sharedPrefs;

  GetAllJobsUsecase({required this.repository, required this.sharedPrefs});

  // Future<Either<Failure, List<JobsEntity>>> getAllJobs(int page) async {
  //   return await repository.getAllJobs(page);
  // }

  Future<Either<Failure, List<JobsEntity>>> getAllRecommended() async {
    final userData = await sharedPrefs.getUser();
    String? id = userData?['_id']?.toString() ?? '';
    print("USER ID IN USRCASE::  $id");
    final data = await repository.getAllRecommended(id);
    return data.fold(
      (l) => Left(l),
      (r) async {
        print(r);
        return Right(r);
      },
    );
  }
}
