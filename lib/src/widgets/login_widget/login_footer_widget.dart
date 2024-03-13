import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartrent_upahan/src/database/firebase_db.dart';

import '../../classes/tenant.dart';
import '../../components/main_components/homepage_tenant.dart';
import '../../components/main_components/signup_page.dart';
import '../../utils/design/images.dart';
import '../../utils/design/sizes.dart';
import '../../utils/design/text_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  LoginFooterWidget({
    super.key,
  });

  FirebaseDB firebase = FirebaseDB();

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
              onPressed: () {
                firebase.signInWithGoogle(context);
              },
              label: Text(tSignInWithGoogle)),
        ),
        const SizedBox(height: tFormHeight - 20),
        TextButton(
          onPressed: () async {
            if (!await FirebaseDB.isNetworkAvailable()) {
              FirebaseDB.showNoInternetError(context);
            } else{
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpPage();
                  },
                ),
              );
            }
          },
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
        const SizedBox(height: 50),
      ],
    );
  }
}