import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String? userId;
  final String? jobId;
  final String? comment;
  final String? firstName;
  final String? lastName;
  final String? image;


  @override
  List<Object?> get props => [userId, jobId, comment,firstName,lastName,image];
  const CommentEntity({
    this.userId,
    this.jobId,
    this.comment,
    this.firstName,
    this.lastName,
    this.image,
  });

  factory CommentEntity.fromJson(Map<String, dynamic> json) => CommentEntity(
      userId: json["userId"], jobId: json["jobsId"], comment: json["comment"], firstName: json["firstName"],lastName: json["lastName"],
      image: json["image"]);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "jobId": jobId,
        "comment": comment,
    "firstName": firstName,
    "lastName": lastName,
    "image": image,

  };

  @override
  String toString() {
    return 'CommentEntity(userId: $userId,jobId: $jobId, comment:$comment,firstName:$firstName,lastName:$lastName,image:$image)';
  }
}
