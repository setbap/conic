import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.orange.shade500,
    onPrimary: Colors.white,
    primaryVariant: Colors.yellow.shade200,
    secondary: Colors.grey.shade900,
    onSecondary: Colors.white,
    secondaryVariant: Colors.grey.shade600,
    surface: Colors.black,
    onSurface: Colors.white,
    background: Colors.black,
    onBackground: Colors.white,
    error: Colors.red,
    onError: Colors.black,
  ),
  snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey.shade900,
      contentTextStyle: TextStyle(
        color: Colors.white,
      )),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade900,
  ),
  chipTheme: ChipThemeData.fromDefaults(
    primaryColor: Color(0xff222431),
    labelStyle: TextStyle(),
    secondaryColor: Colors.grey.shade900,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    primary: Colors.green,
  )),
  cardColor: Colors.white,
  backgroundColor: Colors.black,
  iconTheme: IconThemeData(color: Colors.white),
  cupertinoOverrideTheme: CupertinoThemeData(
    primaryColor: Colors.orange.shade500,
    brightness: Brightness.dark,
  ),
  hintColor: Colors.lightBlue.shade200,
  inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.shade900,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade700, width: 3),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade700, width: 3),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12,
      )),
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    caption: TextStyle(
      fontSize: 10,
    ),
  ),
);

final lightTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.orange.shade500,
    onPrimary: Colors.black,
    primaryVariant: Colors.yellow.shade800,
    secondary: Colors.grey.shade300,
    onSecondary: Colors.black,
    secondaryVariant: Colors.grey.shade600,
    surface: Colors.white,
    onSurface: Colors.black,
    background: Colors.white,
    onBackground: Colors.black,
    error: Colors.red,
    onError: Colors.white,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey.shade600,
    contentTextStyle: TextStyle(
      color: Colors.black,
    ),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.orange,
    elevation: 2,
    titleTextStyle: TextStyle(
      color: Colors.black,
    ),
  ),
  chipTheme: ChipThemeData.fromDefaults(
    primaryColor: Colors.orange,
    labelStyle: TextStyle(),
    secondaryColor: Colors.grey.shade600,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.green.shade600,
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ),
  cardColor: Colors.black,
  backgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.black),
  cupertinoOverrideTheme: CupertinoThemeData(
    primaryColor: Colors.orange.shade500,
    brightness: Brightness.light,
  ),
  hintColor: Colors.grey.shade500,
  inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.shade200,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade300,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300, width: 3),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12,
      )),
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    caption: TextStyle(
      fontSize: 10,
    ),
  ),
);
