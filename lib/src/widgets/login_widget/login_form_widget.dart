import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartrent_upahan/src/classes/emailNum_indicator.dart';
import 'package:smartrent_upahan/src/classes/user.dart';
import 'package:smartrent_upahan/src/components/main_components/homepage_landlord.dart';
import 'package:smartrent_upahan/src/components/main_components/homepage_tenant.dart';
import 'package:smartrent_upahan/src/components/main_components/landlord_maintabview.dart';

import '../../database/firebase_db.dart';
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
  final FirebaseDB firebaseDB = FirebaseDB();
  EmailNumberIndicator? emNumInd;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Declare variables here
  bool _obscurePassword = true;


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: tEmail,
                hintText: tEmail,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: _passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                labelText: tPassword,
                hintText: tPassword,
                border: OutlineInputBorder(),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: _obscurePassword,
            ),
            const SizedBox(height: tFormHeight - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(tForgetPassword),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (!await FirebaseDB.isNetworkAvailable()) {
                    FirebaseDB.showNoInternetError(context);
                  } else{
                    String email = "", password = "";

                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        email = _emailController.text;
                        password = _passwordController.text;
                      });


                      if (await FirebaseDB.loginAccount(email) == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const TenantHomePage();
                            },
                          ),
                        );
                      }
                      else if(await FirebaseDB.loginAccount(email) == 1){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LandlordMainTabView();
                            },
                          ),
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Invalid email or password",
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ),
                        );
                      }
                    }
                  }},
                child: Text(
                  tLogin.toUpperCase(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
