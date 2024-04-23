import 'package:flutter/material.dart';
import 'package:job_finder/config/themes/theme_colors.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: false,
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: appwhite,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 15,
              color: appwhite,
              // fontWeight: FontWeight.w500,
              // fontFamily: 'OpenSans Bold'
            ),
            backgroundColor: appCOlor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ))),
    // inputDecorationTheme: InputDecorationTheme(
    //   border: OutlineInputBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(10.0))),
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(10)),
    //     borderSide: BorderSide(color: Colors.blue),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(10)),
    //       borderSide: BorderSide(color: Colors.green)),
    //   errorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.red),
    //     borderRadius: BorderRadius.circular(8.0),
    //   ),
    // ),
  );
}
