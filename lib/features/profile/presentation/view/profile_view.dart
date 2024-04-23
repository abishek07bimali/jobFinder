import 'dart:io';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/config/routes/app_routes.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/common_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/snackbar/snackbar.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/profile/presentation/viewmodel/userDetails_View_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UserProfileView extends ConsumerStatefulWidget {
  const UserProfileView({Key? key});

  @override
  ConsumerState<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends ConsumerState<UserProfileView> {
  bool hasImage = false;
  late String imagePath = 'assets/images/facebook.png';
  late String defaultImagePath = 'assets/images/facebook.png';
  bool hasProfileUpdated = false;
  String textButton = '';

  late DateTime _lastShakeTime;

  @override
  void initState() {
    super.initState();
    _loadUserDataFromSharedPrefs();
    _lastShakeTime = DateTime.now();
    _initializeAccelerometer();
  }

  late String firstName = '';
  late String lastName = '';
  late String address = '';
  late String email = '';
  late String phone = '';
  late String image = '';

  Future<void> _loadUserDataFromSharedPrefs() async {
    final userData = await ref.read(userSharedPrefsProvider).getUser();
    firstName = userData?['firstName']?.toString() ?? '';
    lastName = userData?['lastName']?.toString() ?? '';
    address = userData?['address']?.toString() ?? '';
    phone = userData?['phone']?.toString() ?? '';
    email = userData?['email']?.toString() ?? '';
    image = userData?['image']?.toString() ?? '';
    bool isVerified = userData?['isVerified'] as bool? ?? false;

    setState(() {
      hasProfileUpdated = isVerified;
      if (image.isNotEmpty) {
        hasImage = true;
        imagePath = image;
      } else {
        hasImage = false;
        imagePath = defaultImagePath;
      }
    });
  }

  void _initializeAccelerometer() {
    accelerometerEvents?.listen((AccelerometerEvent event) {
      final double totalAcceleration =
          event.x.abs() + event.y.abs() + event.z.abs();
      if (totalAcceleration > 20) {
        final DateTime now = DateTime.now();
        if (now.difference(_lastShakeTime) > const Duration(seconds: 1)) {
          _lastShakeTime = now;
          _logout();
        }
      }
    });
  }

  void _logout() {
    ref.read(userDetailViewModelProvider.notifier).logOut(context);
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button for close
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to Logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                _logout();
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future<void> _browseImage(
      WidgetRef widgetRef, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          hasImage = true;
          // ref.read(userViewModelProvider.notifier).updateUser(context, _file)
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'change_password',
                child: Text('Change Password'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
            onSelected: (value) {
              if (value == 'change_password') {
                Navigator.pushReplacementNamed(
                    context, AppRoute.changePassword);
              } else if (value == 'logout') {
                _showLogoutConfirmationDialog(context);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 40 : 8),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Consumer(
                    builder: (context, ref, _) {
                      return RefreshIndicator(
                        onRefresh: () async {},
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:
                                                  hasImage ? appCOlor : appRed,
                                              width: 4.0,
                                            ),
                                          ),
                                          child: CircleAvatar(
                                            radius: 60,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: _img != null
                                                ? FileImage(_img!)
                                                    as ImageProvider<Object>
                                                : NetworkImage(imagePath)
                                                    as ImageProvider<Object>?,
                                            child: !hasImage
                                                ? const Icon(
                                                    Icons.person,
                                                    size: 60,
                                                    color: appRed,
                                                  )
                                                : null,
                                          ),
                                        ),
                                        // Positioned(
                                        //   bottom: 4,
                                        //   right: 4,
                                        //   child: Icon(
                                        //     Icons.camera_alt,
                                        //     size: 20,
                                        //     color: hasImage ? appCOlor : appRed,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    SizedBox(height: isTablet ? 20 : 14),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // User name
                                        commonText(
                                          text: "$firstName $lastName",
                                          isTablet: isTablet,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: appCOlor,
                                        ),
                                        const SizedBox(width: 7),
                                        hasProfileUpdated
                                            ? GestureDetector(
                                                onTap: () {
                                                  showMySnackBar(
                                                      context: context,
                                                      message:
                                                          "You have been verified.",
                                                      color: appCOlor);
                                                },
                                                child: const Icon(
                                                  Icons.check_circle,
                                                  color: appCOlor,
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  showMySnackBar(
                                                      context: context,
                                                      message:
                                                          "Please update your Profile to be verified.",
                                                      color: appRed);
                                                },
                                                child: const Icon(
                                                  Icons.cancel,
                                                  color: appRed,
                                                ),
                                              ),
                                      ],
                                    ),
                                    SizedBox(height: isTablet ? 20 : 14),
                                    commonText(
                                      text: address,
                                      isTablet: isTablet,
                                      fontSize: 20,
                                    ),
                                    SizedBox(height: isTablet ? 20 : 14),
                                    commonText(
                                      text: email,
                                      isTablet: isTablet,
                                      fontSize: 15,
                                    ),
                                    SizedBox(height: isTablet ? 20 : 14),
                                    commonText(
                                      text: phone,
                                      isTablet: isTablet,
                                      fontSize: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: isTablet ? 25 : 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (hasProfileUpdated) {
                                      showMySnackBar(
                                        context: context,
                                        message:
                                            "This Feature is not yet completed!!",
                                        color: appCOlor,
                                      );
                                    } else {
                                      showMySnackBar(
                                        context: context,
                                        message:
                                            "Please update your Profile to be verified.",
                                        color: appRed,
                                      );
                                      Navigator.pushNamed(
                                          context, AppRoute.multiStepForm);
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            appCOlor),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(isTablet ? 200.0 : 140.0, 40)),
                                  ),
                                  child: Text(hasProfileUpdated
                                      ? "Update CV"
                                      : "Update Profile"),
                                ),
                                SizedBox(width: isTablet ? 150 : 60),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoute.updateProfileRoute);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            appCOlor),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(isTablet ? 200.0 : 140.0, 40)),
                                  ),
                                  child: const Text("Edit Profile"),
                                ),
                              ],
                            ),
                            SizedBox(height: isTablet ? 40 : 15),
                            Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonText(
                                        text: "Highlights",
                                        color: kBlackAccent,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    SizedBox(height: isTablet ? 50 : 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 234, 231, 231),
                                              width: 2.0,
                                            ),
                                          ),
                                          child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Image.asset(
                                                  'assets/images/facebook.png')),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              commonText(
                                                  text: "Google Cetification",
                                                  isTablet: isTablet,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                              const SizedBox(height: 8),
                                              const Text(
                                                'Description goes here. More details about the card content.',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: isTablet ? 30 : 10),
                            Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonText(
                                        text: "Work Experiences",
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    SizedBox(height: isTablet ? 50 : 15),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: appCOlor,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Image.asset(
                                                  'assets/images/facebook.png')),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              commonText(
                                                  text:
                                                      "Project Manager in Facebook",
                                                  isTablet: isTablet,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: kBlackAccent),
                                              const SizedBox(height: 8),
                                              const Text(
                                                'Description goes here. More details about the card content.',
                                                style:
                                                    TextStyle(color: appGrey),
                                              ),
                                              SizedBox(
                                                  height: isTablet ? 20 : 10),
                                              const Text(
                                                'Description goes here. More details about the card content.',
                                                style:
                                                    TextStyle(color: appGrey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
