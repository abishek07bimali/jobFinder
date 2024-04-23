import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/networking/hive_service.dart';
import 'package:job_finder/features/homepage/data/model/jobs_hive_model.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';

final jobsLocalDatSourceProvider = Provider.autoDispose<JobsLocalDataSource>(
  (ref) => JobsLocalDataSource(hiveService: ref.read(hiveServiceProvider)),
);

class JobsLocalDataSource {
  final HiveService hiveService;

  JobsLocalDataSource({required this.hiveService});

  // Add jobs
  Future<Either<Failure, bool>> createJobs(JobsEntity jobs) async {
    try {
      JobsHiveModel jobsHiveModel = JobsHiveModel.toHiveModel(jobs);
      hiveService.createJobs(jobsHiveModel);
      print("data source to store local database \n \n \n");
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<JobsEntity>>> getAllJobs(int page) async {
    try {
      print("data source for local \n \n \n");
      List<JobsHiveModel> batches = await hiveService.getAllJobs();
      List<JobsEntity> batchEntities =
          batches.map((e) => JobsHiveModel.toEntity(e)).toList();
      return Right(batchEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
