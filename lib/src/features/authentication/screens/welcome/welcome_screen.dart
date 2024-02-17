import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartrent_upahan/src/constants/colors.dart';
import 'package:smartrent_upahan/src/constants/images.dart';
import 'package:smartrent_upahan/src/constants/sizes.dart';
import 'package:smartrent_upahan/src/constants/text_strings.dart';
import 'package:smartrent_upahan/src/features/authentication/screens/login/login_screen.dart';
import 'package:smartrent_upahan/src/features/authentication/screens/signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage(tWelcomeScreenImage), height: height * 0.35,),
            Column(
              children: [
                Text(
                  tWelcomeTitle,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                Text(
                  tWelcomeSubTitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.to(() => const LoginScreen()),
                      child: Text(tLogin.toUpperCase()),
                    ),
                ),
                SizedBox(
                  width: 15.0,),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => Get.to(() => const SignUpScreen()),
                        child: Text(tSignup.toUpperCase()),
                    ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
