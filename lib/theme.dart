import 'package:flutter/material.dart';

class Constants{
  static Color lightPrimary = Color(0xfffcfcff);
  static Color generalColor = Colors.blueAccent;
  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightPrimary,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightPrimary,
    iconTheme: IconThemeData(
      color:generalColor,
    ),
    appBarTheme: AppBarTheme(
      color: generalColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: lightPrimary
      ),
      textTheme: TextTheme(
        title: TextStyle(
          color: lightPrimary,
          fontSize: 28.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}

