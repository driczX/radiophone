// To parse this JSON data, do
//
//     final bspServices = bspServicesFromJson(jsonString);

import 'dart:convert';

BspServices bspServicesFromJson(String str) =>
    BspServices.fromJson(json.decode(str));

String bspServicesToJson(BspServices data) => json.encode(data.toJson());

class BspServices {
  List<ServicesByCountry> servicesByCountry;

  BspServices({
    this.servicesByCountry,
  });

  factory BspServices.fromJson(Map<String, dynamic> json) => BspServices(
        servicesByCountry: json["servicesByCountry"] == null
            ? null
            : List<ServicesByCountry>.from(json["servicesByCountry"]
                .map((x) => ServicesByCountry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "servicesByCountry": servicesByCountry == null
            ? null
            : List<dynamic>.from(servicesByCountry.map((x) => x.toJson())),
      };
}

class ServicesByCountry {
  int id;
  bool isActive;
  String name;
  List<Service> services;

  ServicesByCountry({
    this.id,
    this.isActive,
    this.name,
    this.services,
  });

  factory ServicesByCountry.fromJson(Map<String, dynamic> json) =>
      ServicesByCountry(
        id: json["id"] == null ? null : json["id"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        name: json["name"] == null ? null : json["name"],
        services: json["services"] == null
            ? null
            : List<Service>.from(
                json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "is_active": isActive == null ? null : isActive,
        "name": name == null ? null : name,
        "services": services == null
            ? null
            : List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class Service {
  int id;
  String name;
  String serviceCategory;
  int serviceGroupId;
  bool isSelected;

  Service({
    this.id,
    this.name,
    this.serviceCategory,
    this.serviceGroupId,
    this.isSelected = false,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        serviceCategory:
            json["service_category"] == null ? null : json["service_category"],
        serviceGroupId:
            json["service_group_id"] == null ? null : json["service_group_id"],
        isSelected: json["is_selected"] == null ? false : true,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "service_category": serviceCategory == null ? null : serviceCategory,
        "service_group_id": serviceGroupId == null ? null : serviceGroupId,
        "is_selected": isSelected == null ? false : isSelected,
      };
}
