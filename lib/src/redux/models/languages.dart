// To parse this JSON data, do
//
//     final languages = languagesFromJson(jsonString);

import 'dart:convert';

Languages languagesFromJson(String str) => Languages.fromJson(json.decode(str));

String languagesToJson(Languages data) => json.encode(data.toJson());

class Languages {
  List<Language> languages;

  Languages({
    this.languages,
  });

  factory Languages.fromJson(Map<String, dynamic> json) => Languages(
        languages: json["languages"] == null
            ? null
            : List<Language>.from(
                json["languages"].map((x) => Language.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "languages": languages == null
            ? null
            : List<dynamic>.from(languages.map((x) => x.toJson())),
      };
}

class Language {
  String code;
  String id;
  bool isActive;
  String name;

  Language({
    this.code,
    this.id,
    this.isActive,
    this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        code: json["code"] == null ? null : json["code"],
        id: json["id"] == null ? null : json["id"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "id": id == null ? null : id,
        "isActive": isActive == null ? null : isActive,
        "name": name == null ? null : name,
      };
}
