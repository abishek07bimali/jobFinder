import 'package:job_finder/features/auth/domain/entity/user_entity.dart';

class ProfileState {
  final bool isLoading;
  final List<UserEntity>? user;

  ProfileState({
    required this.isLoading,
    required this.user,
  });

  factory ProfileState.initial() {
    return ProfileState(
      isLoading: false,
      user: []
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    List<UserEntity>? user
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: user?? this.user,
    );
  }
}
