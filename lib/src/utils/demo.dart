import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class Devicedemo extends StatefulWidget {
  @override
  _DevicedemoState createState() => _DevicedemoState();
}

class _DevicedemoState extends State<Devicedemo> {
  void getdeviceinfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var brand = androidInfo.id;
    setState(() {
      info = brand;
    });
  }

  String info = "";
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
}
