import 'package:flutter/material.dart';
import 'package:smartrent_upahan/src/classes/tenant.dart';
import 'package:smartrent_upahan/src/components/main_components/main_tab_view.dart';
import 'package:smartrent_upahan/src/utils/design/sizes.dart';
import 'package:smartrent_upahan/src/utils/design/text_strings.dart';
import '../../components/sub_components/loading_popup.dart'; // Import the loading popup file

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false; // Track loading state

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
        key: _formKey,
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
                onPressed: _isLoading ? null : () async { // Disable button while loading
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true; // Set loading state to true
                    });
                    // Show loading popup
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return LoadingPopup();
                      },
                    );

                    String email = _emailController.text;
                    String password = _passwordController.text;

                    Tenant tenant = Tenant(
                      name: 'Michael Cye R. Salem',
                      contactInfo: '09978601212',
                      email: email,
                      password: password,
                      status: 1,
                      startDate: DateTime.now(),
                      currentDate: DateTime.now(),
                    );

                    if (await tenant.login()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MainTabView();
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Invalid email or password",
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ),
                      );
                      setState(() {
                        _isLoading = false; // Set loading state to false
                      });
                      Navigator.pop(context); // Close loading popup
                    }
                  }
                },
                child: _isLoading ? CircularProgressIndicator() : Text(tLogin.toUpperCase()), // Display loading indicator if loading
              ),
            ),
          ],
        ),
      ),
    );
  }
}
