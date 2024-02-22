import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../classes/tenant.dart';
import '../../components/main_components/homepage.dart';
import '../../database/firebase_db.dart';
import '../../utils/design/sizes.dart';
import '../../utils/design/text_strings.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {

  final _formkey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _contactinfoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController= TextEditingController();
  TextEditingController _confirmpasswordController= TextEditingController();

  @override
  void dispose(){
    _usernameController.dispose();
    _contactinfoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                label: Text(tFullName),
                suffixIcon: Icon(Icons.person_outline_rounded),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),

            TextFormField(
              controller: _contactinfoController,
              decoration: InputDecoration(
                label: Text(tPhoneNo),
                suffixIcon: Icon(Icons.phone_outlined),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),

            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                label: Text(tEmailAdd),
                suffixIcon: Icon(Icons.email_outlined),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),

            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                label: Text(tPassword),
                suffixIcon: Icon(Icons.password_outlined),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),

            TextFormField(
              controller: _confirmpasswordController,
              decoration: InputDecoration(
                label: Text(tConfirmPassword),
                suffixIcon: Icon(Icons.confirmation_number_outlined),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String name = "", contactInfo = "", email = "", password = "";

                  if(_formkey.currentState!.validate()){
                    setState(() {
                      name = _usernameController.text;
                      contactInfo = _contactinfoController.text;
                      email = _emailController.text;
                      password = _passwordController.text;
                    });

                    Tenant tenant = Tenant(
                        name: name,
                        contactInfo: contactInfo,
                        email: email,
                        password: password,
                        status: 1,
                        startDate: DateTime.now(),
                        currentDate: DateTime.now()
                    );

                    print(tenant);
                    tenant.signUp();
                  }
                },
                child: Text(tSignup.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
