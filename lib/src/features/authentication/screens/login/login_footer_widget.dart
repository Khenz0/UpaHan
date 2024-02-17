import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartrent_upahan/src/constants/images.dart';
import 'package:smartrent_upahan/src/constants/sizes.dart';
import 'package:smartrent_upahan/src/constants/text_strings.dart';
import 'package:smartrent_upahan/src/features/authentication/screens/signup/signup_screen.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: tFormHeight - 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              icon: Image(
                image: AssetImage(tGoogleLogoImage),
                width: 30.0,
              ),
              onPressed: () {},
              label: Text(tSignInWithGoogle)),
        ),
        const SizedBox(height: tFormHeight - 20),
        TextButton(
          onPressed: () => Get.to(() => const SignUpScreen()),
          child: Text.rich(
            TextSpan(
                text: tDontHaveAnAccount,
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text: tSignup,
                    style: TextStyle(color: Colors.cyan),
                  )
                ]
            ),
          ),
        ),
      ],
    );
  }
}