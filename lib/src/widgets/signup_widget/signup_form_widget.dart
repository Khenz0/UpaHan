import 'package:flutter/material.dart';
import '../../components/sub_components/loading_popup.dart'; // Import the loading popup file
import '../../database/firebase_db.dart';
import '../../utils/design/sizes.dart';
import '../../utils/design/text_strings.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _contactinfoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String _selectedRole = 'Tenant'; // Default role is Tenant

  bool _isLoading = false; // Track loading state

  @override
  void dispose() {
    _usernameController.dispose();
    _contactinfoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formKey,
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
                onPressed: _isLoading ? null : _submitForm,
                child: Text(tSignup.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Set loading state to true
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingPopup(); // Show loading popup
        },
      );

      // Your signup logic here

      setState(() {
        _isLoading = false; // Set loading state to false
      });
      Navigator.pop(context); // Close loading popup
    }
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
          validator: (value) {
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
          validator: (value) {
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
          validator: (value) {
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
          validator: (value) {
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
          validator: (value) {
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
          validator: (value) {
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
          validator: (value) {
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
          validator: (value) {
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
