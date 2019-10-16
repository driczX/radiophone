import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tudo/src/modules/login/login_form.dart';
import 'package:tudo/src/widgets/background.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Background(),
              SingleChildScrollView(
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
