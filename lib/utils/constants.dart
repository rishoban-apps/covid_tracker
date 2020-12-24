import 'package:flutter/material.dart';

const kMainThemeColor = Color(0xFF16042E);
const kMainTextColor = Color(0xFFFFFFFF);
const kMainAlternateColor = Colors.orange;
const kCasesCardColor = Color(0xffFFB259);
const kDeathCardColor = Color(0xFFFF5959);
const kActiveCardColor = Color(0xFF4CB5FF);
const kRecoveredCardColor = Color(0xFF4CD97B);

const kCardTextStyle = TextStyle(
  color: kMainTextColor,
  fontWeight: FontWeight.w300,
  fontSize: 25.0,
);

const kBackgroundDecoration = BoxDecoration(
  image: DecorationImage(
      image: AssetImage("images/bg.png"), fit: BoxFit.fitHeight),
);
