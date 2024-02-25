import 'package:flutter/material.dart';

import '../../utils/design/images.dart';
import '../../utils/design/sizes.dart';
import '../../utils/design/text_strings.dart';
import '../../widgets/form_widget/form_header_widget.dart';
import '../../widgets/signup_widget/signup_form_widget.dart';
import 'login_page.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              }),
                        );
                      },
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
