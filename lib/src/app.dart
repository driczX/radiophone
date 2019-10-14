import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_map_location_picker/generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tudo/src/redux/models/app_state.dart';
import 'package:tudo/src/redux/store/store.dart';
import 'package:tudo/src/routes/routes.dart';
import 'package:tudo/src/utils/location_helper.dart';
import 'package:google_map_location_picker/generated/i18n.dart'
    as location_picker;

import 'package:tudo/src/widgets/platform_adaptive.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';

class TudoApp extends StatefulWidget {
  @override
  _TudoAppState createState() => _TudoAppState();
}

class _TudoAppState extends State<TudoApp> {
  // final FirebaseMessaging _messaging = FirebaseMessaging();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  @override
  void initState() {
    super.initState();
    // _messaging.getToken().then((token) {
    //   print("token");
    //   print(token);
    initPlatformState();
    // getPermissionStatus();
    // deviceinfo();
    // });
  }

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData;

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } catch (e) {}
    SharedPreferences devicepref = await SharedPreferences.getInstance();
    devicepref.setString('deviceinfo', jsonEncode(deviceData));
    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Brightness _brightness;
  final store = createStore();
  @override
  Widget build(BuildContext context) {
    DeviceInfoHelper.locatUser();
    return StoreProvider<AppState>(
      store: store,
      child: DynamicTheme(
        defaultBrightness: _brightness,
        data: (brightness) => new ThemeData(
          primarySwatch: Colors.indigo,
          brightness: brightness,
        ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            localizationsDelegates: const [
              location_picker.S.delegate,
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const <Locale>[
              Locale('en', ''),
              Locale('ar', ''),
            ],
            title: 'Tudo',
            debugShowCheckedModeBanner: false,
            theme: defaultTargetPlatform == TargetPlatform.iOS
                ? kIOSTheme
                : kDefaultTheme,
            routes: routes,
          );
        },
      ),
    );
  }
}
