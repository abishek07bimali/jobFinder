import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/profile/data/data_source/userDetails_remote_data_source%20copy.dart';
import 'package:job_finder/features/profile/domain/entity/userDetail_entity.dart';
import 'package:job_finder/features/profile/domain/repository/userDetail_repository.dart';

final userDetailsRemoteRepositoryProvider =
    Provider.autoDispose<IUserDetailRepository>(
  (ref) => UserDetailRemoteImpl(
    userDetailsRemoteDataSource: ref.read(userDetailsRemoteDataSourceProvider),
  ),
);

class UserDetailRemoteImpl extends IUserDetailRepository {
  final UserDetailsRemoteDataSource userDetailsRemoteDataSource;

  UserDetailRemoteImpl({required this.userDetailsRemoteDataSource});

  @override
  Future<Either<Failure, String>> updateUserDetail(
      String id, UserDetailEntity favorite) async {
    final result =
        await userDetailsRemoteDataSource.updateUserDetails(id, favorite);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
}
