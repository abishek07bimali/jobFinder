import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/common_textfield.dart';
import 'package:job_finder/config/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:job_finder/features/auth/presentation/viewmodel/login_user_viewmodel.dart';
import 'package:job_finder/config/themes/theme_colors.dart';

class LoginScreenView extends ConsumerStatefulWidget {
  const LoginScreenView({Key? key});

  @override
  ConsumerState<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends ConsumerState<LoginScreenView> {
  final userController =
      TextEditingController(text: "abi0shekbimali@gmail.com");
  final passwordController = TextEditingController(text: "abi");
  bool _isPasswordVisible = false;

  final GlobalKey<FormState> globalkey = GlobalKey<FormState>();

  Color iconColor = Colors.green;
  Color iconColor1 = Colors.green;

  @override
  Widget build(BuildContext context) {
    // final userState = ref.watch(userLoginViewModelProvider);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (userState.showMessage!) {
    //     final color = userState.status == null ? appCOlor : appRed;
    //     print("USER RESPONSE:::: ${userState.status}");
    //     showMySnackBar(
    //       message: userState.message ?? "",
    //       context: context,
    //       color: color,
    //     );
    //     ref.read(userLoginViewModelProvider.notifier).resetMessage();
    //   }
    // });

    bool isTablet = MediaQuery.of(context).size.shortestSide > 600;
    double buttonWidth = isTablet ? 200.0 : 140.0;
    double buttonHeight = 40.0;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: globalkey,
              child: Padding(
                padding: EdgeInsets.all(isTablet ? 60.0 : 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(isTablet ? 60.0 : 20.0),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    SizedBox(height: isTablet ? 30.0 : 15.0),
                    // common textfield for email
                    commonTextFormField(
                      label: 'Enter the email',
                      controller: userController,
                      prefixIcon: Icon(
                        Icons.email,
                        color: iconColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            iconColor = appRed;
                          });
                          return 'Please enter email';
                        } else {
                          setState(() {
                            iconColor = appCOlor;
                          });
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // common textfield for password
                    commonTextFormField(
                      label: 'Enter the password',
                      controller: passwordController,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: iconColor1,
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
                        color: iconColor1,
                      ),
                      onTapSuffixIcon: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            iconColor1 = appRed;
                          });
                          return 'Please enter password';
                        } else {
                          setState(() {
                            iconColor1 = appCOlor;
                          });
                        }
                        return null;
                      },
                                      maxLines: _isPasswordVisible ? 1 : null,

                    ),
                    SizedBox(height: isTablet ? 30.0 : 15.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (globalkey.currentState!.validate()) {
                            await ref
                                .read(userLoginViewModelProvider.notifier)
                                .loginUser(
                                  context,
                                  userController.text,
                                  passwordController.text,
                                );
                          }
                        },
                        child: const Text(
                          'Login',
                        ),
                        // style: ButtonStyle(
                        //   backgroundColor:
                        //       MaterialStateProperty.all<Color>(Colors.green),
                        // ),
                      ),
                    ),
                    SizedBox(height: isTablet ? 30.0 : 10.0),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.forgetPassword);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: isTablet ? 20.0 : 14.0,
                          fontWeight: FontWeight.bold,
                          color: appCOlor,
                        ),
                      ),
                    ),
                    SizedBox(height: isTablet ? 30.0 : 15.0),
                    Text("Or sign in with",
                        style: TextStyle(fontSize: isTablet ? 20.0 : 15.0)),
                    SizedBox(height: isTablet ? 30.0 : 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            //  facebook signup
                          },
                          style: ButtonStyle(
                            // backgroundColor:
                            //     MaterialStateProperty.all<Color>(Colors.green),
                            minimumSize: MaterialStateProperty.all(
                                Size(buttonWidth, buttonHeight)),
                          ),
                          icon: SizedBox(
                            width: 28,
                            height: 28,
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
                          style: ButtonStyle(
                            // backgroundColor:
                            //     MaterialStateProperty.all<Color>(Colors.green),
                            minimumSize: MaterialStateProperty.all(
                                Size(buttonWidth, buttonHeight)),
                          ),
                          icon: SizedBox(
                            width: 28,
                            height: 28,
                            child: Image.asset(
                              'assets/images/google.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          label: Text('Google'),
                        ),
                      ],
                    ),
                    SizedBox(height: isTablet ? 30.0 : 15.0),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          fontSize: isTablet ? 20.0 : 15.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 81, 79, 79),
                        ),
                        children: [
                          TextSpan(
                            text: "click here!",
                            style: TextStyle(
                              fontSize: isTablet ? 22.0 : 17.0,
                              fontWeight: FontWeight.bold,
                              color: appCOlor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                    context, AppRoute.registerRoute);
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
      ),
    );
  }
}
