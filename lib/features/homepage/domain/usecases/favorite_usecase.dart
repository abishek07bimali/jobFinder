import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/homepage/domain/entity/favorite_entity.dart';
import 'package:job_finder/features/homepage/domain/repository/favorite_repository.dart';

final favoriteUseCaseProvider = Provider.autoDispose<FavoriteUseCase>(
  (ref) => FavoriteUseCase(ref.read(favoriteRepositoryProvider)),
);
class FavoriteUseCase {
  final IFavoriteRepository _favoriteRepository;

  FavoriteUseCase(this._favoriteRepository);

 
  Future<Either<Failure, String>> createFavorite(FavoriteEntiry favorite) async {
    return await _favoriteRepository.createFavorite(favorite);
  }

  
}
