import 'package:audio_wave/app_constants.dart';
import 'package:audio_wave/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(
          appPrimaryDarkColor.value,
          <int, Color>{
            50: appPrimaryDarkColor.withOpacity(0.1),
            100: appPrimaryDarkColor.withOpacity(0.2),
            200: appPrimaryDarkColor.withOpacity(0.3),
            300: appPrimaryDarkColor.withOpacity(0.4),
            400: appPrimaryDarkColor.withOpacity(0.5),
            500: appPrimaryDarkColor.withOpacity(0.6),
            600: appPrimaryDarkColor.withOpacity(0.7),
            700: appPrimaryDarkColor.withOpacity(0.8),
            800: appPrimaryDarkColor.withOpacity(0.9),
            900: appPrimaryDarkColor.withOpacity(1),
          },
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
