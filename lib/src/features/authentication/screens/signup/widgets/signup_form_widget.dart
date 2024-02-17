import 'package:flutter/material.dart';
import 'package:smartrent_upahan/src/constants/sizes.dart';
import 'package:smartrent_upahan/src/constants/text_strings.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text(tFullName),
                suffixIcon: Icon(Icons.person_outline_rounded),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),

            TextFormField(
              decoration: InputDecoration(
                label: Text(tPhoneNo),
                suffixIcon: Icon(Icons.phone_outlined),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),

            TextFormField(
              decoration: InputDecoration(
                label: Text(tEmailAdd),
                suffixIcon: Icon(Icons.email_outlined),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),

            TextFormField(
              decoration: InputDecoration(
                label: Text(tPassword),
                suffixIcon: Icon(Icons.password_outlined),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),

            TextFormField(
              decoration: InputDecoration(
                label: Text(tConfirmPassword),
                suffixIcon: Icon(Icons.confirmation_number_outlined),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(tSignup.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}