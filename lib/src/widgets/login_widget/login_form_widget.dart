import 'package:flutter/material.dart';

import '../../utils/design/sizes.dart';
import '../../utils/design/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: tEmail,
                  hintText: tEmail,
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
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
                onPressed: () {},
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