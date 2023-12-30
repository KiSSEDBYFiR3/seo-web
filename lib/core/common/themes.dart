import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    color: Color.fromARGB(255, 255, 255, 255),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.black),
  cardColor: const Color.fromARGB(255, 210, 219, 223),
  bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color.fromARGB(255, 255, 255, 255)),
  primaryColorLight: const Color.fromARGB(255, 95, 150, 250),
  primaryColor: const Color.fromARGB(255, 30, 54, 242),
  colorScheme: const ColorScheme(
    background: Colors.white,
    primary: Color.fromARGB(255, 30, 54, 242),
    brightness: Brightness.light,
    secondary: Color.fromARGB(26, 122, 252, 1),
    onSecondary: Colors.white,
    onPrimary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    onBackground: Colors.black,
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Colors.black,
  ),
);

final darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    color: Color.fromARGB(255, 28, 26, 26),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
  cardColor: const Color.fromARGB(255, 48, 47, 47),
  bottomSheetTheme:
      BottomSheetThemeData(backgroundColor: Colors.deepPurpleAccent.shade400),
  primaryColor: const Color.fromARGB(255, 30, 54, 242),
  inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 179, 179, 179)),
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 179, 179, 179))),
      fillColor: Color.fromARGB(255, 41, 41, 41)),
  colorScheme: const ColorScheme(
    background: Color.fromARGB(255, 20, 20, 20),
    primary: Color.fromARGB(255, 30, 54, 242),
    brightness: Brightness.dark,
    secondary: Color.fromARGB(26, 2, 153, 10),
    onSecondary: Color.fromARGB(255, 0, 0, 0),
    onPrimary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    onBackground: Colors.white,
    surface: Color.fromARGB(255, 28, 26, 26),
    onSurface: Color.fromARGB(255, 255, 255, 255),
  ),
);
