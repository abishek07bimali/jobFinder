import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';
import 'package:job_finder/features/auth/domain/repository/user_repository.dart';

final addUseruseCase = Provider.autoDispose<AddUseruseCase>((ref) =>
    AddUseruseCase(
        iUserRepository: ref.read(iuserRepositoryProvider),
        sharedPrefs: ref.read(userSharedPrefsProvider)));

class AddUseruseCase {
  final IUserRepository iUserRepository;
  final UserSharedPrefs sharedPrefs;

  AddUseruseCase({required this.iUserRepository, required this.sharedPrefs});

  Future<Either<Failure, String>> createUser(UserEntity user) async {
    return await iUserRepository.createUser(user);
  }

  Future<Either<Failure, String>> updateUser(UserEntity userEntity,File? image) async {
    final userData = await sharedPrefs.getUser();
    String? id = userData?['_id']?.toString() ?? '';
    // print("USER ID IN USRCASE::  $id");
    return await iUserRepository.updateUser(id, userEntity,image);
  }
}
