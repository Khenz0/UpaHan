import 'package:flutter/material.dart';
import 'package:smartrent_upahan/src/common_widgets/form/form_header_widget.dart';
import 'package:smartrent_upahan/src/constants/images.dart';
import 'package:smartrent_upahan/src/constants/sizes.dart';
import 'package:smartrent_upahan/src/constants/text_strings.dart';
import 'package:smartrent_upahan/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              FormHeaderWidget(
                image: tWelcomeScreenImage,
                title: tSignUpTitle,
                subTitle: tSignUpSubTitle,
              ),
              SignUpFormWidget(),
              Column(
                children: [
                  const Text("OR"),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Image(
                        image: AssetImage(tGoogleLogoImage),
                        width: 20.0,
                      ),
                      label: Text(tSignInWithGoogle.toUpperCase()),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: tAlreadyHaveAnAccount,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextSpan(text: tLogin.toUpperCase()),
                          ]
                        ),
                      ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
