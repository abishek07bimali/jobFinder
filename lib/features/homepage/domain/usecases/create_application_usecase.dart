import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/homepage/domain/entity/application_entiry.dart';
import 'package:job_finder/features/homepage/domain/repository/application_repository.dart';
import 'package:job_finder/features/homepage/domain/repository/jobs_repository.dart';

final createApplicationUsecaseProvider =
    Provider.autoDispose<CreateApplicationUsecase>(
  (ref) => CreateApplicationUsecase(
    repository: ref.watch(applicationRepositoryProvider),
    sharedPrefs: ref.read(userSharedPrefsProvider),
    jobRepository: ref.read(jobsRepositoryProvider),
  ),
);

class CreateApplicationUsecase {
  final IApplicationRepository repository;
  final UserSharedPrefs sharedPrefs;
  final IJobsRepository jobRepository;

  CreateApplicationUsecase(
      {required this.repository,
      required this.sharedPrefs,
      required this.jobRepository});

  Future<Either<Failure, String>> createApplication(String jobId) async {
    final userData = await sharedPrefs.getUser();
    String? id = userData?['_id']?.toString() ?? '';
    ApplicationEntity application = ApplicationEntity(userId: id, jobId: jobId);
    final data = await repository.createApplication(application);
    return data.fold(
      (l) => Left(l),
      (r) async {
        return Right(r);
      },
    );
  }

  Future<Either<Failure, List<ApplicationEntity>>> fetchApplications() async {
    try {
      final userData = await sharedPrefs.getUser();
      String? id = userData?['_id']?.toString() ?? '';
      final data = await repository.getAllApplication(id);
      print("APPLICATION DATA USECASE::::::: $data");
      return data.fold(
        (l) => Left(l),
        (r) async {
          print(r);
          return Right(r);
        },
      );
    } catch (e) {
      return Left(Failure(error: 'Failed to fetch applications: $e'));
    }
  }
}
