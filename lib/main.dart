import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartrent_upahan/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:smartrent_upahan/src/utils/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}