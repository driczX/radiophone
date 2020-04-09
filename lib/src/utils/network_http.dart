import 'dart:convert';
import 'dart:async';

import 'package:dio/dio.dart';
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
        // 'AccessToken': '$token',
      };
    } else {
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
    }
  }

  static Future<Map<String, dynamic>> getHttpMethod(String url) async {
    print('url');
    print(url);
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

  // Future Scope to migrate the api to dio packages
  static Future<Map<String, dynamic>> getApi() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("/test?id=12&name=wendu");
    print(response.data.toString());
    return {
      'data': json.decode(response.data),
    };
  }
}
