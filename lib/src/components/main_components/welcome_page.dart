import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartrent_upahan/src/components/main_components/signup_page.dart';
import '../../utils/design/images.dart';
import '../../utils/design/sizes.dart';
import '../../utils/design/text_strings.dart';
import 'login_page.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Cloud shape at the top
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
            top: -50,
            left: -280,
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
            padding: EdgeInsets.all(tDefaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 10.0,
                ),
                Image(
                  image: AssetImage(tWelcomeScreenImage),
                  height: height * 0.35,
                ),
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
                        onPressed: () => Get.to(() => const LoginPage()),
                        child: Text(tLogin.toUpperCase()),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => const SignUpPage()),
                        child: Text(tSignup.toUpperCase()),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
