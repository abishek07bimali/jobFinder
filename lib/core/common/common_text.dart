import 'package:flutter/material.dart';
import 'package:job_finder/config/themes/theme_colors.dart';

Widget commonText({
  required String text,
  bool? isTablet,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize ?? (isTablet ?? false ? 40 : 30),
      fontWeight: fontWeight,
      color: color ?? Colors.black,
    ),
  );
}

Widget commonJobText({
  required String text,
  bool? isTablet,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return Text(
    text,
    style: appSubtitleStyle.copyWith(
      // fontSize: fontSize ?? (isTablet ?? false ? 20 : 16),
      fontSize: 16,
      fontWeight: fontWeight,
      height: 1.5,
      color: kBlack,
    ),
  );
}
