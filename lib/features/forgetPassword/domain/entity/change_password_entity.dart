import 'package:equatable/equatable.dart';

class ChangePasswordEntity extends Equatable {
  final String? userId;
  final String? oldPassword;
  final String? newPassword;


  const ChangePasswordEntity({
    this.userId,
    this.oldPassword,
    this.newPassword,

  });

  @override
  List<Object?> get props => [
        userId,
        oldPassword,
        newPassword,
      ];

  factory ChangePasswordEntity.fromJson(Map<String, dynamic> json) {
    return ChangePasswordEntity(
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
  ChangePasswordEntity copyWith({
    String? userId,
    String? oldPassword,
    String? newPassword,
  }) {
    return ChangePasswordEntity(
      userId: userId ?? this.userId,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

 
  @override
  String toString() {
    return 'ChangePasswordEntiry(userId: $userId, oldPassword: $oldPassword, newPassword: $newPassword)';
  }
}
