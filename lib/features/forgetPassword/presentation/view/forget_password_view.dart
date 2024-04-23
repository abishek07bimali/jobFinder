import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/common_textfield.dart';
import 'package:job_finder/features/forgetPassword/domain/entity/forgetPassword_entity.dart';
import 'package:job_finder/features/forgetPassword/presentation/viewmodel/forgetPassword_View_model.dart';

class EmailVerificationPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmailVerificationPageState();
}

class _EmailVerificationPageState extends ConsumerState<EmailVerificationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController otpCOntroller = TextEditingController();

  Color iconColor = appCOlor;
  Color iconColor1 = appCOlor;
  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }

void _handleForgetPasswordSuccess() {
  _showOTPDialog(context);
}

  void _showOTPDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter OTP'),
          content: commonTextFormField(
            controller: otpCOntroller,
            prefixIcon: Icon(
              Icons.email,
              color: iconColor1,
            ),
            label: 'Enter your OTP',
            validator: (value) {
              if (value == null || value.isEmpty) {
                setState(() {
                  iconColor1 = appRed;
                });
                return 'Please enter OTP';
              } else {
                setState(() {
                  iconColor1 = appCOlor;
                });
              }
              return null;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Verify'),
              onPressed: () {
                ForgetPasswordEntiry forgetPasswordEntiry =
                    ForgetPasswordEntiry(
                        email: _emailController.text, otp: otpCOntroller.text);
                ref
                    .watch(foregetPasswordViewModelProvider.notifier)
                    .verifyOTP(context, forgetPasswordEntiry, _emailController.text);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              commonTextFormField(
                controller: _emailController,
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
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ForgetPasswordEntiry forgetPasswordEntiry =
                        ForgetPasswordEntiry(email: _emailController.text);
                    ref
                        .watch(foregetPasswordViewModelProvider.notifier)
                        .forgetpassword(context, forgetPasswordEntiry,_handleForgetPasswordSuccess);

                    // _showOTPDialog(context);
                  }
                },
                child: Text('Verify Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

