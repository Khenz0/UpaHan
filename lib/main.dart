import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartrent_upahan/src/components/main_components/welcome_page.dart';
import 'package:smartrent_upahan/src/utils/theme/theme.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyByEwH9vl9CBK_rqD-pH9HIcSCMkh0mtRs',
        appId: '1:1041788318836:android:c9df5b05fefec068f48d21',
        messagingSenderId: '1041788318836',
        projectId: 'upahanfinaldb',
        authDomain: 'upahanfinaldb.firebaseapp.com',
    )
  );
  
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
      home: const WelcomePage(),
    );
  }
}