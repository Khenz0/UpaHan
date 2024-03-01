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
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
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
            ],
          ),
        ),
      ),
    );
  }
}
