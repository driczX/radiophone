// To parse this JSON data, do
//
//     final termsandCondition = termsandConditionFromJson(jsonString);

import 'dart:convert';

TermsandCondition termsandConditionFromJson(String str) => TermsandCondition.fromJson(json.decode(str));

String termsandConditionToJson(TermsandCondition data) => json.encode(data.toJson());

class TermsandCondition {
    Data data;

    TermsandCondition({
        this.data,
    });

    factory TermsandCondition.fromJson(Map<String, dynamic> json) => TermsandCondition(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    List<PlatformTermsAndCondition> platformTermsAndConditions;

    Data({
        this.platformTermsAndConditions,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        platformTermsAndConditions: json["platformTermsAndConditions"] == null ? null : List<PlatformTermsAndCondition>.from(json["platformTermsAndConditions"].map((x) => PlatformTermsAndCondition.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "platformTermsAndConditions": platformTermsAndConditions == null ? null : List<dynamic>.from(platformTermsAndConditions.map((x) => x.toJson())),
    };
}

class PlatformTermsAndCondition {
    Country country;
    DateTime endDate;
    String id;
    DateTime startDate;
    String text;
    String type;
    String url;

    PlatformTermsAndCondition({
        this.country,
        this.endDate,
        this.id,
        this.startDate,
        this.text,
        this.type,
        this.url,
    });

    factory PlatformTermsAndCondition.fromJson(Map<String, dynamic> json) => PlatformTermsAndCondition(
        country: json["country"] == null ? null : Country.fromJson(json["country"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        id: json["id"] == null ? null : json["id"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        text: json["text"] == null ? null : json["text"],
        type: json["type"] == null ? null : json["type"],
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "country": country == null ? null : country.toJson(),
        "endDate": endDate == null ? null : endDate.toIso8601String(),
        "id": id == null ? null : id,
        "startDate": startDate == null ? null : startDate.toIso8601String(),
        "text": text == null ? null : text,
        "type": type == null ? null : type,
        "url": url == null ? null : url,
    };
}

class Country {
    String capital;
    String id;

    Country({
        this.capital,
        this.id,
    });

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        capital: json["capital"] == null ? null : json["capital"],
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "capital": capital == null ? null : capital,
        "id": id == null ? null : id,
    };
}
