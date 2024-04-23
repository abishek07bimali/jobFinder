import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const appCOlor = Color(0xff4caf50);
const kBlackAccent = Color.fromARGB(255, 0, 0, 0);
const appwhite = Color(0xFFF6F6F6);
const appRed = Color.fromARGB(255, 255, 0, 0);
const appGrey = Color(0xFF9E9E9E);
const kBlack = Color(0xFF21202A);
const appYellow = Colors.yellow;

var appPageTitleStyle = GoogleFonts.questrial(
  fontSize: 23.0,
  fontWeight: FontWeight.w500,
  color: kBlack,
  wordSpacing: 2.5,
);
var appTitleStyle = GoogleFonts.questrial(
  fontSize: 16.0,
  color: kBlack,
  fontWeight: FontWeight.w400,
);
var appSubtitleStyle = GoogleFonts.questrial(
  fontSize: 15.0,
  color: kBlack,
);

var verificationMessage =
    "Dear Applicant your Application has \n been verified and interview details \n has been sent to you in your email. \n \n Interview Date:";
var contactMessage =
    "For further details please contact to respective company.";
