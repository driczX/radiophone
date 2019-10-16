import 'package:flutter/material.dart';
import 'package:tudo/src/modules/forgot_password/forgotpassword_form.dart';
import 'package:tudo/src/widgets/background.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Background(),
            SingleChildScrollView(
              child: ForgotPassword(),
            ),
          ],
        ),
      ),
    );
  }
}
