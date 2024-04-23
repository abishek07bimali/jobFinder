import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/homepage/domain/entity/comment_entity.dart';
import 'package:job_finder/features/homepage/domain/repository/comment_repository.dart';

final commentUsecaseProvider = Provider.autoDispose<CommentUsecase>(
  (ref) => CommentUsecase(
    repository: ref.watch(commentRepositoryProvider),
    sharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class CommentUsecase {
  final ICommentRepository repository;
  final UserSharedPrefs sharedPrefs;

  CommentUsecase({
    required this.repository,
    required this.sharedPrefs,
  });

  Future<Either<Failure, String>> createComment(String jobId, String comment) async {
    final userData = await sharedPrefs.getUser();
    String? id = userData?['_id']?.toString() ?? '';
    CommentEntity commentEntity = CommentEntity(userId: id, jobId: jobId, comment: comment);
    final data = await repository.createComment(commentEntity);
    return data.fold(
      (l) => Left(l),
      (r) async {
        return Right(r);
      },
    );
  }

  Future<Either<Failure, List<CommentEntity>>> fetchComment(
      String jobsId) async {
    try {
      final data = await repository.getAllComment(jobsId);
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
