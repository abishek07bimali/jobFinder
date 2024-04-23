import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constants/api_endpoints.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/networking/http_service.dart';
import 'package:job_finder/features/homepage/data/dto/get_comment_dto.dart';
import 'package:job_finder/features/homepage/data/model/comment_model.dart';
import 'package:job_finder/features/homepage/domain/entity/comment_entity.dart';

final commentRemoteDataSourceProvider =
Provider.autoDispose<CommentRemoteDataSource>(
      (ref) => CommentRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class CommentRemoteDataSource {
  final Dio dio;
  CommentRemoteDataSource({required this.dio});

  Future<Either<Failure, String>> addComment(CommentEntity favorite) async {
    try {
      CommentAPIModel commentAPIModel = CommentAPIModel.fromEntity(favorite);
      var response = await dio.post(ApiEndpoints.postComment,
          data: commentAPIModel.toJson());
      if (response.statusCode == 200) {
        String message = response.data["message"];
        return Right(message);
      } else {
        return Left(Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }

  Future<Either<Failure, List<CommentEntity>>> fetchComment(
      String jobsId) async {
    try {
      Response response = await dio.get(ApiEndpoints.getComment + jobsId);
      print("dsfsdfsdffsfsd ${response.data}");
      if (response.statusCode == 200) {
        GetAllCommentDTO getAllJobsDTO =
        GetAllCommentDTO.fromJson(response.data);
        List<CommentEntity> comments = getAllJobsDTO.comment
            .map((comment) => CommentAPIModel.toEntity(comment))
            .toList();
        return Right(comments);
      } else {
        print("Failed to fetch applications: ${response.statusCode}");
        return Left(Failure(
            error: 'Failed to fetch applications: ${response.statusCode}'));
      }
    } catch (e) {
      print("Failed to fetch applications: $e");
      return Left(Failure(error: 'Failed to fetch applications: $e'));
    }
  }
}
