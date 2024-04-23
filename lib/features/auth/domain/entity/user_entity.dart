import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String email;
  final String firstName;
  final String lastName;
  final String? password;
  // final String dob;
  final String address;
  final String phone;
  final String? image;

  const UserEntity({
    this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.password,
    required this.address,
    this.image,
  });

  @override
  List<Object?> get props =>
      [userId, email, firstName, lastName, password, address, phone];

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        userId: json["userId"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        password: json["password"],
        // dob: json["dob"],
        address: json["address"],
        phone: json["phone"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
        // "dob": dob,
        "address": address,
        "phone": phone,
        "image": image,
      };

  @override
  String toString() {
    return 'UserEntity(userId: $userId, email: $email, firstName: $firstName, lastName: $lastName,  password: $password , address: $address, phone: $phone, image:$image)';
  }
}
