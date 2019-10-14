import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tudo/src/utils/device_info.dart';

// class Sharedpref {
//   static Future sharedpref() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     String devicedata = jsonEncode(Deviceinformation().  }
// }

import 'package:shared_preferences/shared_preferences.dart';

class DeviceDetails {
  static Future<Map<String, dynamic>> getDeviceDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> deviceDetails =
        jsonDecode(pref.getString('devicedata'));
    print('devicce details');
    print(deviceDetails);
    return deviceDetails;
  }
}
