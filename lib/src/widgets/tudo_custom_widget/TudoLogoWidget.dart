import 'package:flutter/material.dart';

class TudoLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image(
      image: new AssetImage("assets/logo.png"),
      height: 150,
      width: 150,
    );
  }
}
