import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:radiophone/src/routes/routes.dart';
import 'package:radiophone/src/widgets/platform_adaptive.dart';

class RadioPhoneApp extends StatefulWidget {
  @override
  _RadioPhoneAppState createState() => _RadioPhoneAppState();
}

class _RadioPhoneAppState extends State<RadioPhoneApp> {
  Brightness _brightness;

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: _brightness,
      data: (brightness) => new ThemeData(
        primarySwatch: Colors.teal,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'Radio Phone ',
          debugShowCheckedModeBanner: false,
          theme: defaultTargetPlatform == TargetPlatform.iOS
              ? kIOSTheme
              : kDefaultTheme,
          routes: routes,
        );
      },
    );
  }
}
