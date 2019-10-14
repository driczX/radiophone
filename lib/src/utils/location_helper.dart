import 'dart:convert';

// import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceInfoHelper {
  static Future<Map<String, double>> locatUser() async {
    // Location location = new Location();
    Map<String, double> currentLocation = <String, double>{};
    try {
      // Map<String, double> currentLocation = await location.getLocation();
      print(currentLocation);
    } catch (e) {
      print(e);
      currentLocation = null;
    }
    SharedPreferences locatpref = await SharedPreferences.getInstance();
    locatpref.setString('locationinfo', jsonEncode(currentLocation));
    print(currentLocation);
    return currentLocation;
  }
}
