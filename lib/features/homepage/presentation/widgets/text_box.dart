import 'package:flutter/material.dart';
import 'package:job_finder/config/themes/theme_colors.dart';

Widget buildCommonComponents(String text, BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: appCOlor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: appwhite,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}
