import 'package:job_finder/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_api_model.g.dart';

@JsonSerializable()
class UserAPIModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String phone;
  final String? password; 
   String? image; 

  UserAPIModel(
      {this.userId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.address,
      required this.image,
      required this.password});

  factory UserAPIModel.fromJson(Map<String, dynamic> json) {
    return UserAPIModel(
      userId: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      password: json['password '],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'password': password,
      'image': image,
    };
  }

  // From entity to model
  factory UserAPIModel.fromEntity(UserEntity entity) {
    return UserAPIModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phone: entity.phone,
      address: entity.address,
      password: entity.password,
      image: entity.image,
    );
  }

  // From model to entity
  static UserEntity toEntity(UserAPIModel model) {
    return UserEntity(
      firstName: model.firstName,
      lastName: model.lastName,
      email: model.email,
      phone: model.phone,
      address: model.address,
      password: model.password,
      image: model.image,
    );
  }
}
