import 'package:flutter/material.dart';

final mylightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: "Merienda",
  primaryColor: Colors.deepOrange,
  secondaryHeaderColor: Colors.teal[200],
  hintColor: Colors.amber[300],
  hoverColor: Colors.orangeAccent,
  dividerColor: Colors.grey[400],
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 14,
      fontFamily: "Merienda",
      //   color: fontColor,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontFamily: "Merienda",
      //   color: fontColor,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      fontFamily: "Merienda",
      //   color: Colors.black87,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 18,
      fontFamily: "Merienda",
      //   color: Colors.black54,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 13,
      fontFamily: "Merienda",
      // color: lableColor,
      fontWeight: FontWeight.w400,
    ),
  ),
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    primary: Colors.deepOrange,
    secondary: Colors.teal,
  ),
);

final mydarkTheme = ThemeData(
  fontFamily: "Merienda",
  useMaterial3: true,
  // primaryColor: Colors.deepOrange,
  // secondaryHeaderColor: Colors.teal[200],
  hintColor: Colors.amber[300],
  hoverColor: Colors.orangeAccent,
  dividerColor: Colors.grey[400],
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 34,
      fontFamily: "Merienda",
      //  fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontFamily: "Merienda",
      //   fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontFamily: "Merienda",
      //    fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 10,
      fontFamily: "Merienda",
      //    fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      fontFamily: "Merienda",
      //   fontWeight: FontWeight.w400,
    ),

    // bodyMedium: TextStyle(color: Colors.black87),
    // bodySmall: TextStyle(color: Colors.black54),
  ),
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    // primary: Colors.deepOrange,
    // secondary: Colors.teal,
  ),
);
