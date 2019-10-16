// To parse this JSON data, do
//
//     final countries = countriesFromJson(jsonString);

import 'dart:convert';

Countries countriesFromJson(String str) => Countries.fromJson(json.decode(str));

String countriesToJson(Countries data) => json.encode(data.toJson());

class Countries {
  List<Country> countries;

  Countries({
    this.countries,
  });

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        countries: json["countries"] == null
            ? null
            : List<Country>.from(
                json["countries"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": countries == null
            ? null
            : List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}

class Country {
  String capital;
  String code;
  ContactInfo contactInfo;
  String currencyCode;
  String currencySymbol;
  String id;
  String isdCode;
  String name;
  String officialName;

  Country({
    this.capital,
    this.code,
    this.contactInfo,
    this.currencyCode,
    this.currencySymbol,
    this.id,
    this.isdCode,
    this.name,
    this.officialName,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        capital: json["capital"] == null ? null : json["capital"],
        code: json["code"] == null ? null : json["code"],
        contactInfo: json["contactInfo"] == null
            ? null
            : ContactInfo.fromJson(json["contactInfo"]),
        currencyCode:
            json["currencyCode"] == null ? null : json["currencyCode"],
        currencySymbol:
            json["currencySymbol"] == null ? null : json["currencySymbol"],
        id: json["id"] == null ? null : json["id"],
        isdCode: json["isdCode"] == null ? null : json["isdCode"],
        name: json["name"] == null ? null : json["name"],
        officialName:
            json["officialName"] == null ? null : json["officialName"],
      );

  Map<String, dynamic> toJson() => {
        "capital": capital == null ? null : capital,
        "code": code == null ? null : code,
        "contactInfo": contactInfo == null ? null : contactInfo.toJson(),
        "currencyCode": currencyCode == null ? null : currencyCode,
        "currencySymbol": currencySymbol == null ? null : currencySymbol,
        "id": id == null ? null : id,
        "isdCode": isdCode == null ? null : isdCode,
        "name": name == null ? null : name,
        "officialName": officialName == null ? null : officialName,
      };
}

class ContactInfo {
  Info info;

  ContactInfo({
    this.info,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        info: json["Info"] == null ? null : Info.fromJson(json["Info"]),
      );

  Map<String, dynamic> toJson() => {
        "Info": info == null ? null : info.toJson(),
      };
}

class Info {
  Address address;

  Info({
    this.address,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        address:
            json["Address"] == null ? null : Address.fromJson(json["Address"]),
      );

  Map<String, dynamic> toJson() => {
        "Address": address == null ? null : address.toJson(),
      };
}

class Address {
  String city;
  String country;
  String state;
  String street;
  String zipCode;

  Address({
    this.city,
    this.country,
    this.state,
    this.street,
    this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["City"] == null ? null : json["City"],
        country: json["Country"] == null ? null : json["Country"],
        state: json["State"] == null ? null : json["State"],
        street: json["Street"] == null ? null : json["Street"],
        zipCode: json["ZipCode"] == null ? null : json["ZipCode"],
      );

  Map<String, dynamic> toJson() => {
        "City": city == null ? null : city,
        "Country": country == null ? null : country,
        "State": state == null ? null : state,
        "Street": street == null ? null : street,
        "ZipCode": zipCode == null ? null : zipCode,
      };
}
