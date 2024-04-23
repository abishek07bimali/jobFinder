import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/common_textfield.dart';
import 'package:job_finder/features/forgetPassword/domain/entity/forgetPassword_entity.dart';
import 'package:job_finder/features/forgetPassword/presentation/viewmodel/forgetPassword_View_model.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _verifyPasswordController =
      TextEditingController();

  Color iconColor = appCOlor;
  Color iconColor4 = Colors.green;
  bool _isPasswordVisible = false;
  bool _isVerifyPasswordVisible = false;
  final resetPassword = GlobalKey<FormState>();

  bool isValidPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: resetPassword,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              commonTextFormField(
                controller: _newPasswordController,
                prefixIcon: Icon(
                  Icons.lock,
                  color: iconColor,
                ),
                isPasswordVisible: _isPasswordVisible,
                togglePasswordVisibility: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                suffixIcon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: iconColor,
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
                      iconColor = appRed;
                    });
                    return 'Please enter your Password';
                  } else {
                    setState(() {
                      iconColor = appCOlor;
                    });
                  }
                  if (!isValidPassword(value)) {
                    setState(() {
                      iconColor = appRed;
                    });
                    return 'Password must be at least 8 characters long and contain at \nleast one uppercase letter, one digit, and one special character.';
                  }
                  return null;
                },
                maxLines: _isPasswordVisible ? 1 : null,
              ),
              const SizedBox(height: 20.0),
              commonTextFormField(
                controller: _verifyPasswordController,
                prefixIcon: Icon(
                  Icons.lock,
                  color: iconColor4,
                ),
                isPasswordVisible: _isVerifyPasswordVisible,
                togglePasswordVisibility: () {
                  setState(() {
                    _isVerifyPasswordVisible = !_isVerifyPasswordVisible;
                  });
                },
                suffixIcon: Icon(
                  _isVerifyPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: iconColor4,
                ),
                onTapSuffixIcon: () {
                  setState(() {
                    _isVerifyPasswordVisible = !_isVerifyPasswordVisible;
                  });
                },
                label: 'ReEnter your NewPassword',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      iconColor4 = Colors.red;
                    });
                    return 'Please reenter your Password';
                  } else {
                    setState(() {
                      iconColor4 = Colors.green;
                    });
                  }
                  if (_newPasswordController.text !=
                      _verifyPasswordController.text) {
                    setState(() {
                      iconColor4 = Colors.red;
                    });
                    return 'Passwords do not match';
                  }
                  return null;
                },
                maxLines: _isVerifyPasswordVisible ? 1 : null,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (resetPassword.currentState!.validate()) {
                    ForgetPasswordEntiry forgetPasswordEntiry =
                        ForgetPasswordEntiry(
                            password: _newPasswordController.text,
                            email: userEmail);
                    ref
                        .watch(foregetPasswordViewModelProvider.notifier)
                        .resetPassword(context, forgetPasswordEntiry);
                  }
                },
                child: const Text('Save Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
