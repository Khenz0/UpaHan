import 'package:flutter/material.dart';
import 'package:smartrent_upahan/src/constants/images.dart';
import 'package:smartrent_upahan/src/constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key ? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Image(
          image: AssetImage(tWelcomeScreenImage),
          height: size.height * 0.2,),
        Text(tLoginTitle, style: Theme
            .of(context)
            .textTheme
            .displaySmall),
        Text(tLoginSubTitle, style: Theme
            .of(context)
            .textTheme
            .bodyLarge),
      ],
    );
  }
}