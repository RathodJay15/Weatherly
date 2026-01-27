import 'package:flutter/material.dart';
import 'package:weatherly/core/theme/Text_Theme.dart';
import 'package:weatherly/generated/fonts.gen.dart';

class WeatherTheme {
  // WeatherTheme._();

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: const Color.fromARGB(255, 255, 255, 255),
      onPrimary: const Color.fromARGB(255, 41, 182, 246),
      onSecondary: const Color.fromARGB(255, 225, 245, 254),
      onSurface: const Color.fromARGB(255, 255, 249, 225),
      onSurfaceVariant: const Color.fromARGB(255, 41, 182, 246),
      onInverseSurface: const Color.fromARGB(255, 42, 15, 165),
    ),
    fontFamily: FontFamily.poppins,
    textTheme: Text_Theme.textThemeLight,

    useMaterial3: true,
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: const Color.fromARGB(255, 42, 15, 165),
      onPrimary: const Color.fromARGB(255, 20, 19, 68),
      onSecondary: const Color.fromARGB(255, 90, 30, 158),
      onSurface: const Color.fromARGB(255, 138, 1, 165),
      onSurfaceVariant: const Color.fromARGB(255, 229, 126, 250),
      onInverseSurface: const Color.fromARGB(255, 255, 255, 255),
    ),
    fontFamily: FontFamily.poppins,
    textTheme: Text_Theme.textThemeDark,
    useMaterial3: true,
  );
}
