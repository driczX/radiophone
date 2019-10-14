import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkHttp {
  static Future<Map<String, String>> _getHeaders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    if (token != null) {
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      };
    } else {
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
    }
  }

  static Future<Map<String, dynamic>> getHttpMethod(String url) async {
    http.Response response = await http.get(
      url,
      headers: await _getHeaders(),
    );
    Map<String, dynamic> responseJson = {
      'body': json.decode(response.body),
      'headers': response.headers
    };
    return responseJson;
  }

  static Future<Map<String, dynamic>> postHttpMethod(String url, body) async {
    print('url');
    print(url);
    http.Response response = await http.post(
      url,
      headers: await _getHeaders(),
      body: json.encode(body),
    );
    Map<String, dynamic> responseJson = {
      'body': json.decode(response.body),
      'headers': response.headers
    };
    return responseJson;
  }
}
