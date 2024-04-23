import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';
import 'package:job_finder/features/profile/data/data_source/local/userProfile_local_data_source.dart';
import 'package:job_finder/features/profile/domain/repository/userData_local_repository.dart';

final userProfileRepositoryProvider =
    Provider.autoDispose<IUserProfileRepository>(
  (ref) => UserProfileRemoteRepoImpl(
    userProfileLocalDataSource: ref.read(userProfileDataSourceProvider),
  ),
);

class UserProfileRemoteRepoImpl implements IUserProfileRepository {
  final UserProfileLocalDataSource userProfileLocalDataSource;

  UserProfileRemoteRepoImpl({required this.userProfileLocalDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUserData() async {
    return userProfileLocalDataSource.getAllUserProfileData();

    // try {
    //   final eitherResult =
    //       await userProfileLocalDataSource.getAllUserProfileData();
    //   return eitherResult.fold(
    //     (failure) => Left(failure),
    //     (userDataList) => Right(userDataList),
    //   );
    // } catch (e) {
    //   print('Error retrieving user data: $e');
    //   return Left(Failure(error: 'Error retrieving user data: $e'));
    // }
  }
}
