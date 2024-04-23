import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/favorite/domain/entity/favorite_entity.dart';
import 'package:job_finder/features/favorite/domain/repository/jobs_repository.dart';

final getAllFavoriteUsecaseProvider =
    Provider.autoDispose<GetAllFavoriteUsecase>((ref) => GetAllFavoriteUsecase(
        repository: ref.read(favoriteAddRepositoryProvider),
        sharedPrefs: ref.read(userSharedPrefsProvider)));

class GetAllFavoriteUsecase {
  final IFavoriteRepository repository;
  final UserSharedPrefs sharedPrefs;

  GetAllFavoriteUsecase({required this.repository, required this.sharedPrefs});

  Future<Either<Failure, List<FavoriteEntity>>> getAllFavorite() async {
    final userData = await sharedPrefs.getUser();
    String? id = userData?['_id']?.toString() ?? '';
    print("USER ID IN USRCASE::  $id");
    final data = await repository.getAllFavorite(id);
    return data.fold(
      (l) => Left(l),
      (r) async {
        print(r);
        return Right(r);
      },
    );
  }
}
