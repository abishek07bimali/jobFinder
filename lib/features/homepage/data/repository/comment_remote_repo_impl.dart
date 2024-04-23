import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/homepage/data/data_source/remote/comment_remote_dart_source.dart';
import 'package:job_finder/features/homepage/domain/entity/comment_entity.dart';
import 'package:job_finder/features/homepage/domain/repository/comment_repository.dart';

final commentRemoteRepositoryProvider =
    Provider.autoDispose<ICommentRepository>(
  (ref) => CommentRemoteImpl(
    commentRemoteDataSource: ref.read(commentRemoteDataSourceProvider),
  ),
);

class CommentRemoteImpl extends ICommentRepository {
  final CommentRemoteDataSource commentRemoteDataSource;

  CommentRemoteImpl({required this.commentRemoteDataSource});

  @override
  Future<Either<Failure, String>> createComment(
      CommentEntity commentEntity) async {
    final result =
        await commentRemoteDataSource.addComment(commentEntity);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }


   @override
  Future<Either<Failure, List<CommentEntity>>> getAllComment(String jobsId) {
       return commentRemoteDataSource.fetchComment(jobsId);
  }
}
