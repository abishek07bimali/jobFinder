import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/failure/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userSharedPrefsProvider = Provider<UserSharedPrefs>((ref) {
  return UserSharedPrefs();
});

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;
  // Set user token
  Future<Either<Failure, bool>> setUserToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('token', token);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get user token
  Future<Either<Failure, String?>> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final token = _sharedPreferences.getString('token');
      return right(token);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete token
  Future<Either<Failure, bool>> deleteUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('token');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Store user data in SharedPreferences
  Future<bool> setUser(Map<String, dynamic> user) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String userDataString = jsonEncode(user);
      await _sharedPreferences.setString('user', userDataString);
      print("USER LOCAL ::: $user");
      return true;
    } catch (e) {
      print("USER LOCAL ERROR WHILE SETTING THE DATA ::: ${e.toString()}");
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUser() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      String? userDataString = _sharedPreferences.getString('user');

      if (userDataString == null || userDataString.isEmpty) {
        return null;
      }
      Map<String, dynamic> userData = jsonDecode(userDataString);
      // Update the code to parse 'isVerified' as a boolean
      String? isVerifiedString = userData['isVerified'].toString();
      bool isVerified = isVerifiedString.toLowerCase() == 'true';
      userData['isVerified'] = isVerified;
      return userData;
    } catch (e) {
      print("USER LOCAL ERROR:::${e.toString()}");
      return null;
    }
  }

  Future<String?> getUserRawData() async {
  try {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? userDataString = _sharedPreferences.getString('user');
    return userDataString;
  } catch (e) {
    print("USER LOCAL ERROR:::${e.toString()}");
    return null;
  }
}

  // Delete userdata
  Future<Either<Failure, bool>> deleteUserData() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('user');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  Future<void> clearAllSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    prefs.remove('user');

    print("logout successfull");
  }
}
