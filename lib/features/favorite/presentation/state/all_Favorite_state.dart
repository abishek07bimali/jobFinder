import 'package:job_finder/features/auth/domain/entity/user_entity.dart';
import 'package:job_finder/features/favorite/domain/entity/favorite_entity.dart';

class FavoriteState {
  final List<FavoriteEntity> jobs;
  final bool isLoading;
  final List<UserEntity>? user;

  FavoriteState({
    required this.jobs,
    required this.isLoading,
    required this.user,
  });

  factory FavoriteState.initial() {
    return FavoriteState(
      jobs: [],
      isLoading: false,
      user: []
    );
  }

  FavoriteState copyWith({
    List<FavoriteEntity>? jobs,
    bool? isLoading,
    List<UserEntity>? user
  }) {
    return FavoriteState(
      jobs: jobs ?? this.jobs,
      isLoading: isLoading ?? this.isLoading,
      user: user?? this.user,
    );
  }
}
