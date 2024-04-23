import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';

final userDataProvider = FutureProvider<UserData>((ref) async {
  print("USERDATA SHRED PRED");
  var userDataSharedPref = await ref.watch(userSharedPrefsProvider).getUser();
  print("USER DATA LOAD LOCAL::${userDataSharedPref}");
  String? firstName = userDataSharedPref?['firstName']?.toString() ?? '';
  String? lastName = userDataSharedPref?['lastName']?.toString() ?? '';
  String? address = userDataSharedPref?['address']?.toString() ?? '';
  String? phone = userDataSharedPref?['phone']?.toString() ?? '';
  String? email = userDataSharedPref?['email']?.toString() ?? '';
  String? image = userDataSharedPref?['image']?.toString() ?? '';
  bool isVerified = userDataSharedPref?['isVerified'] as bool? ?? false;

  print("USERNAME PRINT::${firstName}::${lastName}");

  // Check if the profile is updated (verified)
  bool isProfileUpdated = isVerified;

  // Create UserData object
  UserData userData = UserData(
      firstName: firstName,
      address: address,
      phone: phone,
      lastName: lastName,
      email: email,
      isVerified: isVerified,
      isProfileUpdated: isProfileUpdated,
      image: image);

  return userData;
});

class UserData {
  final String? firstName;
  final String? address;
  final String? email;
  final String? phone;
  final String? lastName;
  final String? image;
  final bool isVerified;
  final bool isProfileUpdated;

  UserData({
    required this.firstName,
    required this.address,
    required this.email,
    required this.phone,
    required this.lastName,
    required this.image,
    required this.isVerified,
    required this.isProfileUpdated,
  });
}






// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:job_finder/features/auth/domain/entity/user_entity.dart';

// import 'package:job_finder/features/profile/domain/usecases/get_all_userData_usecase.dart';
// import 'package:job_finder/features/profile/presentation/state/profile_state.dart';

// final userDataProvider =
//     StateNotifierProvider<UserDetailJobsViewModel, ProfileState>((ref) {
//   final getAllUserDataUsecase = ref.read(getAllUserDataUsecaseProvider);
//   return UserDetailJobsViewModel(getAllUserDataUsecase);
// });

// class UserDetailJobsViewModel extends StateNotifier<ProfileState> {
//   final GetAllUserDataUsecase getAllUserDataUsecase;

//   UserDetailJobsViewModel(
//     this.getAllUserDataUsecase,
//   ) : super(ProfileState.initial()) {
//     getuserData();
//   }

//   Future<void> resetState() async {
//     state = ProfileState.initial();
//     getuserData();
//   }

//   Future<void> getuserData() async {
//     state = state.copyWith(isLoading: true);
//     getAllUserDataUsecase.getAllUserData().then((value) => value.fold(
//           (l) {
//             state = state.copyWith(isLoading: false);
//           },
//           (r) {
//             state = state.copyWith(isLoading: false, user: r);
//             print("Data in viewModel of favorite list:: $r");
//           } as Null Function(dynamic l) Function(
//               Null Function(dynamic l) previousValue, UserEntity element),
//         ));
//   }
  
// }
