import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/homepage/data/data_source/remote/favorite_remote_data_source.dart';
import 'package:job_finder/features/homepage/domain/entity/favorite_entity.dart';
import 'package:job_finder/features/homepage/domain/repository/favorite_repository.dart';

final favoriteRemoteRepositoryProvider =
    Provider.autoDispose<IFavoriteRepository>(
  (ref) => FavoriteRemoteImpl(
    favoriteRemoteDataSource: ref.read(favoriteRemoteDataSourceProvider),
  ),
);

class FavoriteRemoteImpl extends IFavoriteRepository {
  final FavoriteRemoteDataSource favoriteRemoteDataSource;

  FavoriteRemoteImpl({required this.favoriteRemoteDataSource});

  @override
  Future<Either<Failure, String>> createFavorite(
      FavoriteEntiry favorite) async {
    final result = await favoriteRemoteDataSource.addFavorite(favorite);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
}
