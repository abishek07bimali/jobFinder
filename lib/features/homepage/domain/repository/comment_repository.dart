import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/homepage/data/repository/comment_remote_repo_impl.dart';

import 'package:job_finder/features/homepage/domain/entity/comment_entity.dart';

final commentRepositoryProvider = Provider.autoDispose<ICommentRepository>(
  (ref) => ref.read(commentRemoteRepositoryProvider),
);

abstract class ICommentRepository {
  Future<Either<Failure, String>> createComment(CommentEntity commentEntiry);
  Future<Either<Failure, List<CommentEntity>>> getAllComment(String jobsId);
}
