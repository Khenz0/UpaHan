import 'package:flutter/material.dart';
import 'package:smartrent_upahan/main.dart';

void main() => runApp(const MyApp());

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark, // Change this to light or dark to see the theme change
    );
  }
}