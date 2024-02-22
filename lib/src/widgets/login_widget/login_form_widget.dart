import 'package:flutter/material.dart';
import 'package:smartrent_upahan/src/classes/tenant.dart';
import 'package:smartrent_upahan/src/components/main_components/homepage.dart';

import '../../utils/design/sizes.dart';
import '../../utils/design/text_strings.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formkey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController= TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: tEmail,
                  hintText: tEmail,
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    labelText: tPassword,
                    hintText: tPassword,
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.remove_red_eye_sharp),
                    )
                )
            ),
            const SizedBox(height: tFormHeight - 20),
            Align(alignment: Alignment.centerRight,child: TextButton(onPressed: () {}, child: Text(tForgetPassword))
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String email = "", password = "";

                  setState(() {
                    email = _emailController.text;
                    password = _passwordController.text;
                  });
                  Tenant tenant = Tenant(
                      name: 'Michael Cye R. Salem',
                      contactInfo: '09978601212',
                      email: email,
                      password: password,
                      status: 1,
                      startDate: DateTime.now(),
                      currentDate: DateTime.now()
                  );

                  if (await tenant.login()){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                        return const HomePage(title: 'Smart Rent');
                      }),
                    );
                  }

                  //tenant.login();
                },
                child: Text(tLogin.toUpperCase()
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}