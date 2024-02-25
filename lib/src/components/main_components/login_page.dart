import 'package:flutter/material.dart';
import '../../utils/design/sizes.dart';
import '../../widgets/login_widget/login_footer_widget.dart';
import '../../widgets/login_widget/login_form_widget.dart';
import '../../widgets/login_widget/login_header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
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


