import 'package:hive_flutter/hive_flutter.dart';
import 'package:job_finder/config/constants/hive_table_constant.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';
import 'package:uuid/uuid.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String? password;

  // @HiveField(5)
  // final String dob;

  @HiveField(5)
  final String address;

  @HiveField(6)
  final String phone;

  // empty constructor
  UserHiveModel.empty()
      : this(
            userId: '',
            email: '',
            firstName: '',
            lastName: '',
            password: '',
            address: '',
            phone: '');

  UserHiveModel({
    String? userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    // required this.dob,
    required this.address,
    required this.phone,
  }) : userId = userId ?? const Uuid().v4();

// Convert Entity to Hive Object
  factory UserHiveModel.toHiveModel(UserEntity entity) => UserHiveModel(
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        password: entity.password,
        // dob: entity.dob,
        address: entity.address,
        phone: entity.phone,
      );

  // Convert Hive Object to Entity
  static UserEntity toEntity(UserHiveModel hiveModel) => UserEntity(
        userId: hiveModel.userId,
        firstName: hiveModel.firstName,
        lastName: hiveModel.lastName,
        email: hiveModel.email,
        password: hiveModel.password,
        // dob: hiveModel.dob,
        address: hiveModel.address,
        phone: hiveModel.phone,
      );

  @override
  String toString() {
    return 'UserHiveModel(userId: $userId, email: $email, firstname: $firstName, lastName: $lastName, password: $password, address: $address, phone: $phone)';
  }
}
