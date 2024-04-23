import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:job_finder/features/auth/domain/repository/user_repository.dart';

final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
  (ref) => LoginUseCase(ref.watch(iuserRepositoryProvider)),
);

class LoginUseCase {
  final IUserRepository _userRepository;

  LoginUseCase(this._userRepository);

  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    return await _userRepository.loginUser(email, password);
  }
}
