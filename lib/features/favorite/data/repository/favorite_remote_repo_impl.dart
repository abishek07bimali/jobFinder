import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/favorite/data/data_source/remote/favorite_remote_data_source.dart';
import 'package:job_finder/features/favorite/domain/repository/jobs_repository.dart';
import 'package:job_finder/features/favorite/domain/entity/favorite_entity.dart';

final favoriteRemoteRepositoryProvider = Provider.autoDispose<IFavoriteRepository>(
  (ref) => FavoriteRemoteRepoImpl(
    favoriteRemoteDataSource: ref.read(FavoriteRemoteDataSourceProvider),
  ),
);

class FavoriteRemoteRepoImpl implements IFavoriteRepository {
  final FavoriteRemoteDataSource favoriteRemoteDataSource;

  FavoriteRemoteRepoImpl(
      {required this.favoriteRemoteDataSource});

  @override
  Future<Either<Failure, List<FavoriteEntity>>> getAllFavorite(String userId) {
    return favoriteRemoteDataSource.getAllFavorite(userId);
  }


}
