// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  String status;
  String error;
  Data data;

  ApiResponse({
    this.status,
    this.error,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => new ApiResponse(
        status: json["status"] == null ? null : json["status"],
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "error": error == null ? null : error,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => new Data();

  Map<String, dynamic> toJson() => {};
}
