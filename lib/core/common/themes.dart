import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  cardColor: const Color.fromARGB(255, 210, 219, 223),
  primaryColorDark: const Color.fromARGB(255, 0, 50, 124),
  bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color.fromARGB(255, 95, 180, 250)),
  primaryColorLight: const Color.fromARGB(255, 95, 150, 250),
  primaryColor: const Color.fromARGB(255, 95, 180, 250),
  colorScheme: const ColorScheme(
      background: Colors.white,
      primary: Color.fromARGB(255, 95, 100, 250),
      brightness: Brightness.light,
      secondary: Color.fromARGB(26, 122, 252, 1),
      onSecondary: Colors.white,
      onPrimary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      onBackground: Colors.black,
      surface: Color.fromARGB(255, 69, 147, 248),
      onSurface: Colors.black),
);

final darkTheme = ThemeData(
  cardColor: const Color.fromARGB(255, 75, 65, 82),
  primaryColorDark: const Color.fromARGB(255, 60, 1, 83),
  bottomSheetTheme:
      BottomSheetThemeData(backgroundColor: Colors.deepPurpleAccent.shade400),
  primaryColorLight: const Color.fromARGB(255, 187, 20, 238),
  primaryColor: Colors.deepPurpleAccent,
  inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 179, 179, 179)),
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 179, 179, 179))),
      fillColor: Color.fromARGB(255, 41, 41, 41)),
  colorScheme: const ColorScheme(
    background: Color.fromARGB(255, 20, 20, 20),
    primary: Color.fromARGB(255, 112, 18, 189),
    brightness: Brightness.dark,
    secondary: Color.fromARGB(26, 2, 153, 10),
    onSecondary: Color.fromARGB(255, 0, 0, 0),
    onPrimary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    onBackground: Colors.white,
    surface: Color.fromARGB(255, 198, 160, 248),
    onSurface: Colors.white,
  ),
);
