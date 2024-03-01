import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartrent_upahan/src/components/main_components/login_page.dart';
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

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value){
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text(tFullName),
                suffixIcon: Icon(Icons.person_outline_rounded),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),

            TextFormField(
              controller: _contactinfoController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value){
                if (value!.isEmpty) {
                  return 'Please enter a contact number';
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text(tPhoneNo),
                suffixIcon: Icon(Icons.phone_outlined),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),

            TextFormField(
              controller: _emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value){
                if (value!.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text(tEmailAdd),
                suffixIcon: Icon(Icons.email_outlined),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),

            TextFormField(
            controller: _passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if (value!.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: tPassword,
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                child: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            obscureText: _obscurePassword, // Toggle the visibility of the entered text
          ),


            const SizedBox(height: tFormHeight - 20),

            TextFormField(
            controller: _confirmpasswordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if (value!.isEmpty) {
                return 'Please confirm password';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: tConfirmPassword,
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
                child: Icon(
                  _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            obscureText: _obscureConfirmPassword, // Toggle the visibility of the entered text
          ),

            const SizedBox(height: tFormHeight - 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String name = "", contactInfo = "", email = "", password = "";

                  if(_formkey.currentState!.validate()) {
                    setState(() {
                      name = _usernameController.text;
                      contactInfo = _contactinfoController.text;
                      email = _emailController.text;
                      password = _passwordController.text;
                    });
                  }

                  if(name != "" && contactInfo != "" && email != "" && password != ""){
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

                      if(await tenant.signUp(context)){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              }),
                        );
                      }
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
