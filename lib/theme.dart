import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = const Color.fromARGB(255, 7, 16, 21);
  static Color secondaryColor = const Color.fromARGB(255, 31, 139, 35);
  static Color whiteColor = Colors.white;

  static final lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: whiteColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: primaryColor),
      bodyText2: TextStyle(color: primaryColor),
    ),
    iconTheme: IconThemeData(color: primaryColor),
  );

  static final darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: whiteColor),
      bodyText2: TextStyle(color: whiteColor),
    ),
    iconTheme: IconThemeData(color: whiteColor),
  );
}
