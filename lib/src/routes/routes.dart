import 'package:flutter/widgets.dart';
import 'package:tudo/src/modules/login/login_screen.dart';
// import 'package:tudo/src/modules/bsp_service/bsp_service_page.dart';
import 'package:tudo/src/modules/splash/splash.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => SplashScreen(),
  '/login': (BuildContext context) => LoginScreen(),
};
