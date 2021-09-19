import 'package:flutter/material.dart';

ThemeData light = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.transparent),
  primaryColor: Colors.black,
);
ThemeData dark = ThemeData.dark().copyWith();
