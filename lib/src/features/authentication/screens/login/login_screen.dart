import 'package:flutter/material.dart';
import 'package:smartrent_upahan/src/constants/sizes.dart';
import 'package:smartrent_upahan/src/features/authentication/screens/login/login_footer_widget.dart';
import 'package:smartrent_upahan/src/features/authentication/screens/login/login_form_widget.dart';
import 'package:smartrent_upahan/src/features/authentication/screens/login/login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* -- Section-1 [Header] -- */
                LoginHeaderWidget(),
                /* -- Section-2 [Form] -- */
                LoginForm(),
                /* -- Section-3 [Footer] -- */
                LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


