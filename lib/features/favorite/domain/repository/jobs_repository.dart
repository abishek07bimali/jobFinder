import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/favorite/data/repository/favorite_remote_repo_impl.dart';
import 'package:job_finder/features/favorite/domain/entity/favorite_entity.dart';


final favoriteAddRepositoryProvider = Provider.autoDispose<IFavoriteRepository>(
  (ref) => ref.read(favoriteRemoteRepositoryProvider),
);

abstract class IFavoriteRepository {
  Future<Either<Failure, List<FavoriteEntity>>> getAllFavorite(String userId);
}
