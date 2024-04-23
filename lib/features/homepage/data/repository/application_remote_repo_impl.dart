import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/homepage/data/data_source/remote/application_remote_data_source.dart';
import 'package:job_finder/features/homepage/domain/entity/application_entiry.dart';
import 'package:job_finder/features/homepage/domain/repository/application_repository.dart';

final applicationRemoteRepositoryProvider =
    Provider.autoDispose<IApplicationRepository>(
  (ref) => ApplicationRemoteImpl(
    applicationRemoteDataSource: ref.read(applicationRemoteDataSourceProvider),
  ),
);

class ApplicationRemoteImpl extends IApplicationRepository {
  final ApplicationRemoteDataSource applicationRemoteDataSource;

  ApplicationRemoteImpl({required this.applicationRemoteDataSource});

  @override
  Future<Either<Failure, String>> createApplication(
      ApplicationEntity applicationEntiry) async {
    final result =
        await applicationRemoteDataSource.addApplication(applicationEntiry);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }


   @override
  Future<Either<Failure, List<ApplicationEntity>>> getAllApplication(String userId) {
       return applicationRemoteDataSource.fetchApplicationsForUser(userId);
  }
}
