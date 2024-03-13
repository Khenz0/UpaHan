import 'package:flutter/material.dart';
import 'package:smartrent_upahan/src/classes/emailNum_indicator.dart';
import 'package:smartrent_upahan/src/classes/landlord.dart';
import 'package:smartrent_upahan/src/classes/property.dart';
import 'package:smartrent_upahan/src/classes/tenant.dart';
import 'package:smartrent_upahan/src/classes/user.dart';
import 'package:smartrent_upahan/src/components/main_components/login_page.dart';
import '../../database/firebase_db.dart';
import '../../utils/design/images.dart';
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

  FirebaseDB firebase = FirebaseDB();
  final _formkey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _contactinfoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _propertyAddressController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String _selectedRole = 'Tenant'; // Default role is Tenant

  @override
  void dispose() {
    _usernameController.dispose();
    _contactinfoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _propertyNameController.dispose();
    _propertyAddressController.dispose();
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
            DropdownButtonFormField<String>(
              value: _selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue!;
                });
              },
              items: <String>['Tenant', 'Landlord'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            const SizedBox(height: tFormHeight - 20),

            if (_selectedRole == 'Tenant')
              _buildTenantFields(),
            if (_selectedRole == 'Landlord')
              _buildLandlordFields(),

            const SizedBox(height: tFormHeight - 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String name = "", contactInfo = "", email = "", password = "", confPass = "", startDate = "", propertyName = "", propertyAdd = "";
                  EmailNumberIndicator emailIndicator = EmailNumberIndicator(email: "", userIndicator: -1);

                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      name = _usernameController.text;
                      contactInfo = _contactinfoController.text;
                      email = _emailController.text;
                      password = _passwordController.text;
                      confPass = _confirmPasswordController.text;

                      if(_selectedRole == 'Landlord'){
                        propertyName = _propertyNameController.text;
                        propertyAdd = _propertyAddressController.text;
                      }

                    });
                    // Perform sign up based on selected role
                    if (_selectedRole == 'Tenant') {
                      Tenant tenant = Tenant(
                          name: name,
                          contactInfo: contactInfo,
                          email: email,
                          password: password,
                          boardingHouse: "",
                          status: 3,
                          startDate: DateTime.now(),
                          currentDate: DateTime.now(),
                      );

                      if (await tenant.signUp(context)){
                        tenant.createTenantData(emailIndicator);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              }),
                        );
                      }
                    } else if (_selectedRole == 'Landlord') {
                      Property property = Property(propertyName: propertyName, address: propertyAdd);

                      Landlord landlord = Landlord(
                          name: name,
                          contactInfo: contactInfo,
                          email: email,
                          password: password,
                          property: property
                      );

                      if (await landlord.signUp(context)){
                        //property.createPropertyData();
                        landlord.createLandlordData(emailIndicator);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              }),
                        );
                      }
                    }
                  }
                },
                child: Text(tSignup.toUpperCase()),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),

            Column(
              children: [
                const Text("OR"),
                const SizedBox(height: tFormHeight - 20),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      firebase.signInWithGoogle(context);
                    },
                    icon: const Image(
                      image: AssetImage(tGoogleLogoImage),
                      width: 20.0,
                    ),
                    label: Text(tSignInWithGoogle.toUpperCase()),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginPage();
                        },
                      ),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: tAlreadyHaveAnAccount,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextSpan(text: tLogin.toUpperCase()),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTenantFields() {
    return Column(
      children: [
        TextFormField(
          controller: _usernameController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
          decoration: InputDecoration(
            label: Text('Tenant Full Name'),
            suffixIcon: Icon(Icons.person_outline_rounded),
          ),
        ),
        const SizedBox(height: tFormHeight - 20),
        // Add other tenant-specific text form fields here
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

        // will be automatic since google sign in
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
          controller: _confirmPasswordController,
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



      ],
    );
  }

  Widget _buildLandlordFields() {
    return Column(
      children: [
        TextFormField(
          controller: _usernameController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
          decoration: InputDecoration(
            label: Text('Landlord Full Name'),
            suffixIcon: Icon(Icons.person_outline_rounded),
          ),
        ),
        const SizedBox(height: tFormHeight - 20),
        // Add other landlord-specific text form fields here
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
          controller: _propertyNameController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter boarding house name';
            }
            return null;
          },
          decoration: InputDecoration(
            label: Text('Boarding House Name'),
            suffixIcon: Icon(Icons.person_outline_rounded),
          ),
        ),

        const SizedBox(height: tFormHeight - 20),

        TextFormField(
          controller: _propertyAddressController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter boarding house address';
            }
            return null;
          },
          decoration: InputDecoration(
            label: Text('Boarding House Address'),
            suffixIcon: Icon(Icons.person_outline_rounded),
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
          controller: _confirmPasswordController,
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
      ],
    );
  }
}
