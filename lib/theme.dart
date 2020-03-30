import 'package:flutter/material.dart';

class Constants{

  static String appName = "Municipality App";

  //Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
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

  static ThemeData darkTheme = ThemeData(
    backgroundColor: darkPrimary,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkPrimary,
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

