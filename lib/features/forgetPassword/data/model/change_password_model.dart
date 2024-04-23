import 'package:job_finder/features/forgetPassword/domain/entity/change_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_model.g.dart';

@JsonSerializable()
class ChangePasswordAPIModel {
  final String? userId;
  final String? oldPassword;
  final String? newPassword;

  ChangePasswordAPIModel({
    this.userId,
    this.oldPassword,
    this.newPassword,
  });

  factory ChangePasswordAPIModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordAPIModel(
      userId: json['userId'],
      oldPassword: json['oldPassword'],
      newPassword: json['newPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }

  factory ChangePasswordAPIModel.fromEntity(ChangePasswordEntity entity) {
    return ChangePasswordAPIModel(
        userId: entity.userId,
        oldPassword: entity.oldPassword,
        newPassword: entity.newPassword);
  }

  static ChangePasswordAPIModel toEntity(ChangePasswordAPIModel model) {
    return ChangePasswordAPIModel(
      userId: model.userId,
      oldPassword: model.oldPassword,
      newPassword: model.newPassword,
    );
  }
}
