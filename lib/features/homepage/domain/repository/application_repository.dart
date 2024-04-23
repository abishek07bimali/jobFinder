import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/homepage/data/repository/application_remote_repo_impl.dart';
import 'package:job_finder/features/homepage/domain/entity/application_entiry.dart';

final applicationRepositoryProvider = Provider.autoDispose<IApplicationRepository>(
  (ref) => ref.read(applicationRemoteRepositoryProvider),
);

abstract class IApplicationRepository {
  Future<Either<Failure, String>> createApplication(ApplicationEntity applicationEntiry);
  Future<Either<Failure, List<ApplicationEntity>>> getAllApplication(String userId);
}
