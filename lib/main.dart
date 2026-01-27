import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      themeMode: ThemeMode.system,
      theme: WeatherTheme.light,
      darkTheme: WeatherTheme.dark,
      title: 'Weatherly',
      home: LandingScreen(),
    );
  }
}
