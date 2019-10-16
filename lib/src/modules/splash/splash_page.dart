import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/navigation_helper.dart';
import 'package:tudo/src/widgets/loader.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userLang = pref.getString('user_lang');
    if (userLang != null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userString = preferences.getString('user');
      if (userString != null) {
        NavigationHelper.navigatetoMainscreen(context);
      } else {
        NavigationHelper.navigatetologinscreen(context);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
      }
    } else {
      NavigationHelper.navigatetolanguagescreen(context);
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 3));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 150.0),
                child: Center(
                  child: Loader(color: colorStyles["primary"]),
                ),
              ),
            ],
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'assets/logo.png',
                width: animation.value * 220,
                height: animation.value * 220,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
