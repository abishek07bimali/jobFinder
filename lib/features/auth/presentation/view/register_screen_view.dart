import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/common_textfield.dart';
import 'package:job_finder/config/routes/app_routes.dart';
import 'package:job_finder/core/common/snackbar/snackbar.dart';
import 'package:job_finder/features/auth/domain/entity/user_entity.dart';
import 'package:job_finder/features/auth/presentation/viewmodel/add_user_viewmodel.dart';

class RegisterScreenView extends ConsumerStatefulWidget {
  const RegisterScreenView({Key? key});

  @override
  ConsumerState<RegisterScreenView> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends ConsumerState<RegisterScreenView> {
  final emailController = TextEditingController(text: "Abishek@gmail.com");
  final passwordController = TextEditingController(text: "Abishek123@");
  final fullnameController = TextEditingController(text: "Abishek");
  final lastNameController = TextEditingController(text: "Bimali");
  final phoneController = TextEditingController(text: "1234567890");
  final addressController = TextEditingController(text: "asdf");
  final otpController = TextEditingController();

  final registerglobalkey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  Color iconColor = appCOlor;
  Color iconColor1 = appCOlor;
  Color iconColor2 = appCOlor;
  Color iconColor3 = appCOlor;
  Color iconColor4 = appCOlor;
  Color textspanColor = appCOlor;
  Color textspan = Color.fromARGB(255, 81, 79, 79);

  int generateRandomCode() {
    Random random = Random();
    int otp = random.nextInt(90000) + 10000;
    print(otp);
    return otp;
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^\d{10}$').hasMatch(phoneNumber);
  }

  bool isStrongPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  void _showOTPDialog(BuildContext context, WidgetRef ref) {
    int generatedOTP = generateRandomCode();

    final List<TextEditingController> otpControllers =
        List.generate(5, (_) => TextEditingController());
    final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

    final userState = ref.watch(userViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userState.showMessage!) {
        showMySnackBar(message: "Account has been created", context: context);
        ref.read(userViewModelProvider.notifier).resetMessage();
      }
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: RichText(
            text: TextSpan(
              text: "Enter the ",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: textspan,
              ),
              children: [
                TextSpan(
                  text: "OTP",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: textspanColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, AppRoute.loginRoute);
                    },
                ),
                TextSpan(
                  text: " sent to your email",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: textspan,
                  ),
                ),
              ],
            ),
          ),
          content: Form(
            key: otpFormKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return SizedBox(
                  width: 40,
                  child: TextFormField(
                    controller: otpControllers[index],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length != 1 ||
                          !value.contains(RegExp(r'[0-9]'))) {
                        return '!';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    buildCounter: (BuildContext context,
                            {int? currentLength,
                            int? maxLength,
                            bool? isFocused}) =>
                        null,
                  ),
                );
              }),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (otpFormKey.currentState!.validate()) {
                    String enteredOTP = otpControllers
                        .map((controller) => controller.text)
                        .join();

                    if (enteredOTP == generatedOTP.toString()) {
                      // Correct OTP
                      // showMySnackBar(
                      //   message: "Account has been created.",
                      //   context: context,
                      // );

                      // UserEntity user = UserEntity(
                      //   email: emailController.text,
                      //   password: passwordController.text,
                      //   firstName: fullnameController.text,
                      //   lastName: fullnameController.text,
                      //   phone: phoneController.text,
                      //   address: addressController.text,
                      // );
                      // ref.read(userViewModelProvider.notifier).addUser(user);

                      showMySnackBar(
                        message: "Account has been created.",
                        context: context,
                      );
                      Navigator.pushNamed(context, AppRoute.loginRoute);
                    } else {
                      // Incorrect OTP
                      showMySnackBar(
                        message: "Incorrect OTP. Please try again.",
                        context: context,
                        color: appRed,
                      );
                    }
                  }
                },
                // style: ElevatedButton.styleFrom(
                //   primary: Colors.green,
                // ),
                child: Text("Verify"),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final userState = ref.watch(userViewModelProvider);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (userState.showMessage!) {
    //     final color = userState.status == null ? appCOlor : appRed;
    //     showMySnackBar(
    //       message: userState.message ?? "",
    //       context: context,
    //       color: color,
    //     );
    //     ref.read(userViewModelProvider.notifier).resetMessage();
    //   }
    // });

    bool isTablet = MediaQuery.of(context).size.shortestSide > 600;
    double buttonWidth = isTablet ? 200.0 : 140.0;
    double buttonHeight = 40.0;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: registerglobalkey,
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 40.0 : 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: isTablet ? 25.0 : 15.0),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(height: isTablet ? 25.0 : 15.0),
                  RichText(
                    text: TextSpan(
                      text: "Create an account and ",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: textspan,
                      ),
                      children: [
                        TextSpan(
                          text: "start your journey with us!",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: textspanColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isTablet ? 25.0 : 15.0),
                  commonTextFormField(
                    controller: emailController,
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
                  SizedBox(height: isTablet ? 20.0 : 15.0),
                  commonTextFormField(
                    controller: fullnameController,
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
                  SizedBox(height: isTablet ? 20.0 : 15.0),
                  commonTextFormField(
                    controller: lastNameController,
                    prefixIcon: Icon(
                      Icons.person,
                      color: iconColor1,
                    ),
                    label: 'Enter your LastName',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          iconColor1 = appRed;
                        });
                        return 'Please enter your LastName';
                      } else {
                        setState(() {
                          iconColor1 = appCOlor;
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
                  SizedBox(height: isTablet ? 20.0 : 15.0),
                  commonTextFormField(
                    controller: passwordController,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: iconColor4,
                    ),
                    isPasswordVisible: _isPasswordVisible,
                    togglePasswordVisibility: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    suffixIcon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: iconColor4,
                    ),
                    onTapSuffixIcon: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    label: 'Enter your Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          iconColor4 = appRed;
                        });
                        return 'Please enter your Password';
                      } else {
                        setState(() {
                          iconColor4 = appCOlor;
                        });
                      }
                      if (!isStrongPassword(value)) {
                        setState(() {
                          iconColor4 = appRed;
                        });
                        return 'Password must be at least 8 characters long and contain at \nleast one uppercase letter, one digit, and one special character.';
                      }
                      return null;
                    },
                    maxLines: _isPasswordVisible ? 1 : null,
                  ),
                  SizedBox(height: isTablet ? 20.0 : 15.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (registerglobalkey.currentState!.validate()) {
                          // _showOTPDialog(context, ref);
                          UserEntity user = UserEntity(
                            email: emailController.text,
                            password: passwordController.text,
                            firstName: fullnameController.text,
                            lastName: lastNameController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                          );
                          ref
                              .read(userViewModelProvider.notifier)
                              .addUser(context, user);
                        }
                      },
                      // style: ElevatedButton.styleFrom(
                      //   primary: Colors.green,
                      // ),
                      child: const Text(
                        'Verify and Continue',
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? 20.0 : 15.0),
                  Text("Or sign up with",
                      style: TextStyle(fontSize: isTablet ? 20.0 : 15.0)),
                  SizedBox(height: isTablet ? 10.0 : 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          //  facebook signup
                        },
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.green,
                          minimumSize: Size(buttonWidth, buttonHeight),
                        ),
                        icon: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                            'assets/images/facebook.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        label: Text('Facebook'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          //  google signup
                        },
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.green,
                          minimumSize: Size(buttonWidth, buttonHeight),
                        ),
                        icon: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                            'assets/images/google.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        label: Text('Google'),
                      ),
                    ],
                  ),
                  SizedBox(height: isTablet ? 15.0 : 10.0),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontSize: isTablet ? 20.0 : 15.0,
                        fontWeight: FontWeight.bold,
                        color: textspan,
                      ),
                      children: [
                        TextSpan(
                          text: "click here!",
                          style: TextStyle(
                            fontSize: isTablet ? 20.0 : 15.0,
                            fontWeight: FontWeight.bold,
                            color: textspanColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.loginRoute,
                              );
                            },
                        ),
                      ],
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
