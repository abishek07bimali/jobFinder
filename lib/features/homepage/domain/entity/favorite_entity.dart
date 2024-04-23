import 'package:equatable/equatable.dart';

class FavoriteEntiry extends Equatable {
  final String? favId;
  final String? jobsId;
  final String? userId;

  @override
  List<Object?> get props => [favId,jobsId, userId];
  const FavoriteEntiry({
    this.favId,
    this.jobsId,
    this.userId,
  });

  factory FavoriteEntiry.fromJson(Map<String, dynamic> json) => FavoriteEntiry(
        favId: json["favId"],
        jobsId: json["jobsId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "favId": favId,
        "jobsId": jobsId,
        "userId": userId,
      };

  @override
  String toString() {
    return 'FavoriteEntiry(favId: $favId,jobsId: $jobsId,userId: $userId,))';
  }
}
