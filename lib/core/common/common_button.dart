import 'package:flutter/material.dart';

commonButtom({
  required String text,
  required bool isTablet,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  bool? onPressed,
}) {
  return ElevatedButton(
      onPressed: () {
        onPressed;
      },
      child: Text(text),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        minimumSize:
            MaterialStateProperty.all(Size(isTablet ? 200.0 : 140.0, 40)),
      ));
}
