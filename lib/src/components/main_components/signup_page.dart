import 'package:flutter/material.dart';

import '../../utils/design/images.dart';
import '../../utils/design/sizes.dart';
import '../../utils/design/text_strings.dart';
import '../../widgets/form_widget/form_header_widget.dart';
import '../../widgets/signup_widget/signup_form_widget.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Cloud shape at the top
            Positioned(
              top: -40,
              left: -160,
              child: Container(
                width: MediaQuery.of(context).size.width + 100,
                height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[200],
                ),
              ),
            ),
            Positioned(
              top: -120,
              left: -50,
              child: Container(
                width: MediaQuery.of(context).size.width + 100,
                height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[200],
                ),
              ),
            ),
            Positioned(
              top: -100,
              left: -150,
              child: Container(
                width: MediaQuery.of(context).size.width + 100,
                height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[200],
                ),
              ),
            ),
            Positioned(
              top: -100,
              left: 50,
              child: Container(
                width: MediaQuery.of(context).size.width + 100,
                height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[200],
                ),
              ),
            ),
            Positioned(
              top: -50,
              left: 170,
              child: Container(
                width: MediaQuery.of(context).size.width + 100,
                height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[200],
                ),
              ),
            ),
            Positioned(
              top: -40,
              left: -260,
              child: Container(
                width: MediaQuery.of(context).size.width + 100,
                height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[200],
                ),
              ),
            ),

            // Cloud shape at the bottom
            Positioned(
              bottom: -150,
              right: -50,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(150.0),
                  topRight: Radius.circular(150.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width + 100,
                  height: height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[200],
                  ),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                children: [
                  FormHeaderWidget(
                    image: tWelcomeScreenImage,
                    title: tSignUpTitle,
                    subTitle: tSignUpSubTitle1,
                  ),
                  SignUpFormWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
