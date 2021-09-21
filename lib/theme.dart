import 'package:flutter/material.dart';

ThemeData light = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.transparent),
  primaryColor: Colors.black,
  primaryColorLight: Colors.black,
  accentColor: Colors.transparent,
);
ThemeData dark = ThemeData.dark().copyWith();
