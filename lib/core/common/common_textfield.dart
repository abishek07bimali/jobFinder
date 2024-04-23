import 'package:flutter/material.dart';
import 'package:job_finder/config/themes/theme_colors.dart';

commonTextFormField({
  required String label,
  String? Function(String?)? validator,
  required TextEditingController? controller,
  Icon? prefixIcon,
  bool isPasswordVisible = false,
  VoidCallback? togglePasswordVisibility,
  Icon? suffixIcon,
  VoidCallback? onTapSuffixIcon,
  TextInputType? textInputType,
  int? maxLines,
    bool? enabled = true, 
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordVisible,
    maxLines: maxLines,
    enabled: enabled,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon != null
          ? InkWell(
              onTap: onTapSuffixIcon,
              child: suffixIcon,
            )
          : null,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: appCOlor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: appCOlor),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: appRed),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    validator: validator,
    // style: TextStyle(fontSize: 20),
  );
}
