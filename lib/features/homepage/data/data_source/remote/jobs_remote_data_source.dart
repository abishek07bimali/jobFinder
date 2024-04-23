import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constants/api_endpoints.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/networking/http_service.dart';
import 'package:job_finder/features/homepage/data/dto/get_all_jobs_dto.dart';
import 'package:job_finder/features/homepage/data/dto/get_all_recommended_jobs_dto.dart';
import 'package:job_finder/features/homepage/data/model/jobs_api_model.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';

final jobsRemoteDataSourceProvider = Provider.autoDispose<JobsRemoteDataSource>(
  (ref) => JobsRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class JobsRemoteDataSource {
  final Dio dio;

  JobsRemoteDataSource({required this.dio});

  Future<Either<Failure, List<JobsEntity>>> getAllJobs(
      int page, String userid) async {
    try {
      var response = await dio.get(
        ApiEndpoints.getAllJobs + userid,
        queryParameters: {
          '_page': page,
          '_limit': ApiEndpoints.limitPage,
        },
      );
      if (response.statusCode == 200) {
        GetAllJobsDTO getAllJobsDTO = GetAllJobsDTO.fromJson(response.data);
        List<JobsEntity> jobsList = getAllJobsDTO.jobs
            .map(
              (jobs) => JobsAPIModel.toEntity(jobs),
            )
            .toList();
        print(getAllJobsDTO);
        return Right(jobsList);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }

  Future<Either<Failure, List<JobsEntity>>> getAllRecommended(
      String userId) async {
    try {
      var response = await dio.get(ApiEndpoints.getAllRecommendedJobs + userId);
      print("Response::::$response");
      if (response.statusCode == 200) {
        GetAllRecommendedJobsDTO getAllJobsDTO =
            GetAllRecommendedJobsDTO.fromJson(response.data);
        List<JobsEntity> jobsList = getAllJobsDTO.recommendedJobs
            .map(
              (jobs) => JobsAPIModel.toEntity(jobs),
            )
            .toList();
        print(getAllJobsDTO);
        return Right(jobsList);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }

//  Future<Either<Failure, List<JobsEntity>>> getAllJobs(int page) async {
//     try {
//       final response = await dio.get(
//         ApiEndpoints.getAllJobs,
//         queryParameters: {
//           '_page': page,
//           '_limit': ApiEndpoints.limitPage,
//         },
//       );
//       final data = response.data as List;
//       final posts = data.map((e) => JobsEntity.fromJson(e)).toList();
//       return Right(posts);
//     } on DioException catch (e) {
//       return Left(Failure(error: e.response?.data['message']));
//     }
//   }

  // Future<Either<Failure, JobsEntity>> getJobById(String jobId) async {
  //   try {
  //     var response = await dio.get('${ApiEndpoints.getIndividualJobs}/$jobId');
  //     if (response.statusCode == 200) {
  //       JobsEntity job = JobsEntity.fromJson(response.data);
  //       return Right(job);
  //     } else {
  //       return Left(Failure(
  //         error: response.statusMessage.toString(),
  //         statusCode: response.statusCode.toString(),
  //       ));
  //     }
  //   } on DioError catch (e) {
  //     return Left(Failure(error: e.response?.data['message']));
  //   }
  // }
}
