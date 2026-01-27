import 'package:flutter/material.dart';

class Text_Theme {
  // Text_Theme._();

  static TextTheme textThemeLight = TextTheme(
    displayLarge: const TextStyle().copyWith(
      fontSize: 70,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 42, 15, 165),
    ),

    displayMedium: const TextStyle().copyWith(
      fontSize: 70,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 255, 193, 7),
    ),
    headlineLarge: const TextStyle().copyWith(
      fontSize: 25,
      fontWeight: FontWeight.w200,
      color: const Color.fromARGB(255, 42, 15, 165),
    ),
    displaySmall: const TextStyle().copyWith(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 42, 15, 165),
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w900,
      color: const Color.fromARGB(255, 42, 15, 165),
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: const Color.fromARGB(255, 42, 15, 165),
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 22,
      fontWeight: FontWeight.normal,
      color: const Color.fromARGB(255, 42, 15, 165),
    ),
  );

  static TextTheme textThemeDark = TextTheme(
    displayLarge: const TextStyle().copyWith(
      fontSize: 70,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 255, 255, 255),
    ),
    displayMedium: const TextStyle().copyWith(
      fontSize: 70,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 255, 193, 7),
    ),
    displaySmall: const TextStyle().copyWith(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 255, 255, 255),
    ),
    headlineLarge: const TextStyle().copyWith(
      fontSize: 25,
      fontWeight: FontWeight.w200,
      color: const Color.fromARGB(255, 255, 255, 255),
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w900,
      color: const Color.fromARGB(255, 255, 255, 255),
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: const Color.fromARGB(255, 255, 255, 255),
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 22,
      fontWeight: FontWeight.normal,
      color: const Color.fromARGB(255, 255, 255, 255),
    ),
  );
}
