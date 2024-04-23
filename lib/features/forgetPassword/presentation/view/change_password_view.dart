import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/routes/app_routes.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/common_textfield.dart';
import 'package:job_finder/features/forgetPassword/domain/entity/change_password_entity.dart';
import 'package:job_finder/features/forgetPassword/presentation/viewmodel/change_password_View_model.dart';

class ChangePasswordByUserView extends ConsumerStatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordByUserView> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _verifyPasswordController =
      TextEditingController();

  Color iconColorOld = appCOlor;
  Color iconColorNew = appCOlor;
  Color iconColorVerify = Colors.green;
  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isVerifyPasswordVisible = false;
  final changePasswordKey = GlobalKey<FormState>();

  bool isValidPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appCOlor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: appwhite,
          ),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, AppRoute.navigationRoute),
        ),
        title: Text(
          "Change Password",
          style: appTitleStyle.copyWith(
              fontWeight: FontWeight.bold, color: appwhite),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: changePasswordKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              commonTextFormField(
                controller: _oldPasswordController,
                prefixIcon: Icon(
                  Icons.lock,
                  color: iconColorOld,
                ),
                isPasswordVisible: _isOldPasswordVisible,
                togglePasswordVisibility: () {
                  setState(() {
                    _isOldPasswordVisible = !_isOldPasswordVisible;
                  });
                },
                suffixIcon: Icon(
                  _isOldPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: iconColorOld,
                ),
                onTapSuffixIcon: () {
                  setState(() {
                    _isOldPasswordVisible = !_isOldPasswordVisible;
                  });
                },
                label: 'Old Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      iconColorOld = appRed;
                    });
                    return 'Please enter your old password';
                  } else {
                    setState(() {
                      iconColorOld = appCOlor;
                    });
                  }
                  // Add any validation rules for old password here if needed
                  return null;
                },
                maxLines: _isOldPasswordVisible ? 1 : null,
              ),
              const SizedBox(height: 20.0),
              commonTextFormField(
                controller: _newPasswordController,
                prefixIcon: Icon(
                  Icons.lock,
                  color: iconColorNew,
                ),
                isPasswordVisible: _isNewPasswordVisible,
                togglePasswordVisibility: () {
                  setState(() {
                    _isNewPasswordVisible = !_isNewPasswordVisible;
                  });
                },
                suffixIcon: Icon(
                  _isNewPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: iconColorNew,
                ),
                onTapSuffixIcon: () {
                  setState(() {
                    _isNewPasswordVisible = !_isNewPasswordVisible;
                  });
                },
                label: 'New Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      iconColorNew = appRed;
                    });
                    return 'Please enter your new password';
                  } else {
                    setState(() {
                      iconColorNew = appCOlor;
                    });
                  }
                  if (!isValidPassword(value)) {
                    setState(() {
                      iconColorNew = appRed;
                    });
                    return 'Password must be at least 8 characters long and contain at least one uppercase letter, one digit, and one special character.';
                  }
                  return null;
                },
                maxLines: _isNewPasswordVisible ? 1 : null,
              ),
              const SizedBox(height: 20.0),
              commonTextFormField(
                controller: _verifyPasswordController,
                prefixIcon: Icon(
                  Icons.lock,
                  color: iconColorVerify,
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
                  color: iconColorVerify,
                ),
                onTapSuffixIcon: () {
                  setState(() {
                    _isVerifyPasswordVisible = !_isVerifyPasswordVisible;
                  });
                },
                label: 'Re-enter New Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      iconColorVerify = Colors.red;
                    });
                    return 'Please re-enter your new password';
                  } else {
                    setState(() {
                      iconColorVerify = Colors.green;
                    });
                  }
                  if (_newPasswordController.text !=
                      _verifyPasswordController.text) {
                    setState(() {
                      iconColorVerify = Colors.red;
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
                  if (changePasswordKey.currentState!.validate()) {
                    ChangePasswordEntity changePasswordEntity =
                        ChangePasswordEntity(
                            oldPassword: _oldPasswordController.text,
                            newPassword: _newPasswordController.text);
                    ref
                        .watch(changePasswordViewModelProvider.notifier)
                        .changePassword(context, changePasswordEntity);
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
