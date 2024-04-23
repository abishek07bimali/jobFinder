import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/common_textfield.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';
import 'package:job_finder/features/auth/presentation/viewmodel/add_user_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserDetailInputViewState();
}

class _UserDetailInputViewState extends ConsumerState<EditProfileView> {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final imageController = TextEditingController();

  final _moreUserDetail = GlobalKey<FormState>();

  var cities = ["Male", "Female", "Other"];

  DateTime? selectedDate;

  Color iconColor = appCOlor;
  Color iconColor1 = appCOlor;
  Color iconColor2 = appCOlor;
  Color iconColor3 = appCOlor;
  Color iconColor4 = appCOlor;
  Color textspanColor = appCOlor;

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^\d{10}$').hasMatch(phoneNumber);
  }

  @override
  void initState() {
    super.initState();
    _loadUserDataFromSharedPrefs();
  }

  bool hasImage = false;
  late String imagePath = 'assets/images/facebook.png';
  late String defaultImagePath = 'assets/images/facebook.png';
  bool hasProfileUpdated = false;

  late String firstName = '';
  late String lastName = '';
  late String address = '';
  late String email = '';
  late String phone = '';
  late String image = '';
  late String id = '';

  Future<void> _loadUserDataFromSharedPrefs() async {
    final userData = await ref.read(userSharedPrefsProvider).getUser();
    firstName = userData?['firstName']?.toString() ?? '';
    lastName = userData?['lastName']?.toString() ?? '';
    address = userData?['address']?.toString() ?? '';
    phone = userData?['phone']?.toString() ?? '';
    email = userData?['email']?.toString() ?? '';
    image = userData?['image']?.toString() ?? '';
    bool isVerified = userData?['isVerified'] as bool? ?? false;

    id = userData?['_id']?.toString() ?? '';

    firstNameController.text = firstName;
    lastNameController.text = lastName;
    addressController.text = address;
    phoneController.text = phone;
    emailController.text = email;
    // imageController.text = ;
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
        backgroundColor: appCOlor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: appwhite,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "",
          style: appTitleStyle.copyWith(
              fontWeight: FontWeight.bold, color: appwhite),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _moreUserDetail,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: const TextSpan(
                        text: "Edit your ",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 81, 79, 79),
                        ),
                        children: [
                          TextSpan(
                            text: "Personal Information ",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: appCOlor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.grey[300],
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                            ),
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(22),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      checkCameraPermission();
                                      _browseImage(ref, ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.camera),
                                    label: const Text('Camera'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _browseImage(ref, ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.image),
                                    label: const Text('Gallery'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: hasImage ? appCOlor : appRed,
                                  width: 4.0,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.transparent,
                                backgroundImage: _img != null
                                    ? FileImage(_img!) as ImageProvider<Object>
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
                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: hasImage ? appCOlor : appRed,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  commonTextFormField(
                    controller: emailController,
                    enabled: false,
                    prefixIcon: Icon(
                      Icons.email,
                      color: iconColor,
                    ),
                    label: 'Enter your Email Address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          iconColor = appRed;
                        });
                        return 'Please enter your Email address';
                      } else {
                        setState(() {
                          iconColor = appCOlor;
                        });
                      }
                      if (!isValidEmail(value)) {
                        setState(() {
                          iconColor = appRed;
                        });
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  commonTextFormField(
                    controller: firstNameController,
                    prefixIcon: Icon(
                      Icons.person,
                      color: iconColor1,
                    ),
                    label: 'Enter your FirstName',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          iconColor1 = appRed;
                        });
                        return 'Please enter your FirstName';
                      } else {
                        setState(() {
                          iconColor1 = appCOlor;
                        });
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  commonTextFormField(
                    controller: lastNameController,
                    prefixIcon: Icon(
                      Icons.person,
                      color: iconColor4,
                    ),
                    label: 'Enter your LastName',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          iconColor4 = appRed;
                        });
                        return 'Please enter your LastName';
                      } else {
                        setState(() {
                          iconColor4 = appCOlor;
                        });
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isTablet ? 20.0 : 15.0),
                  commonTextFormField(
                    controller: phoneController,
                    textInputType: TextInputType.number,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: iconColor2,
                    ),
                    label: 'Enter your Phone Number',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          iconColor2 = appRed;
                        });
                        return 'Please enter your phone number';
                      } else {
                        setState(() {
                          iconColor2 = appCOlor;
                        });
                      }
                      if (!isValidPhoneNumber(value)) {
                        setState(() {
                          iconColor2 = appRed;
                        });
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isTablet ? 20.0 : 15.0),
                  commonTextFormField(
                    controller: addressController,
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: iconColor3,
                    ),
                    label: 'Enter your Address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          iconColor3 = appRed;
                        });
                        return 'Please enter your Address';
                      } else {
                        setState(() {
                          iconColor3 = appCOlor;
                        });
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_moreUserDetail.currentState!.validate()) {
                          // _showOTPDialog(context, ref);
                          UserEntity user = UserEntity(
                              email: emailController.text,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                              image: imageController.text.isNotEmpty
                                  ? imageController.text
                                  : 'null',
                              userId: id);
                          ref
                              .read(userViewModelProvider.notifier)
                              .updateUser(context, user, _img);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(appCOlor),
                      ),
                      child: Consumer(
                        builder: (context, watch, child) {
                          final loading =
                              ref.watch(userViewModelProvider).isLoading;
                          return loading
                              ? const Text('Saving....')
                              : const Text('Update');
                        },
                      ),
                    ),
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
