// To parse this JSON data, do
//
//     final bspSignupCommonModel = bspSignupCommonModelFromJson(jsonString);

import 'dart:convert';

import 'dart:io';

BspSignupCommonModel bspSignupCommonModelFromJson(String str) =>
    BspSignupCommonModel.fromJson(json.decode(str));

String bspSignupCommonModelToJson(BspSignupCommonModel data) =>
    json.encode(data.toJson());

class BspSignupCommonModel {
  String businessLegalName;
  String businessPhoneNumber;
  String businessYear;
  String numberofEmployees;
  String businessLegalAddress;
  BusinessGeoLocation businessGeoLocation;
  String businessType;
  bool isLicensed;
  String businessCheck;
  List<Licensed> licensed;
  List<Licensed> unlicensed;
  bool isWalkin;
  bool isHome;
  bool isOnDemand;
  String profileComment;
  List<int> servicesIds;
  List<Service> services;
  List<BusinessProfilePicture> businessProfilePictures;
  Map<String, dynamic> bspLicenseAuthorityType;
  Map<String, dynamic> businessTypes;

  BspSignupCommonModel({
    this.businessLegalName,
    this.businessPhoneNumber,
    this.businessYear,
    this.numberofEmployees,
    this.businessLegalAddress,
    this.businessGeoLocation,
    this.businessType,
    this.isLicensed,
    this.businessCheck,
    this.licensed,
    this.unlicensed,
    this.isWalkin,
    this.isHome,
    this.isOnDemand,
    this.profileComment,
    this.servicesIds,
    this.services,
    this.businessProfilePictures,
    this.bspLicenseAuthorityType,
    this.businessTypes,
  });

  factory BspSignupCommonModel.fromJson(Map<String, dynamic> json) =>
      BspSignupCommonModel(
        businessLegalName: json["business_legal_name"] == null
            ? null
            : json["business_legal_name"],
        businessPhoneNumber: json["business_phone_number"] == null
            ? null
            : json["business_phone_number"],
        businessYear:
            json["business_year"] == null ? null : json["business_year"],
        numberofEmployees: json["numberof_Employees"] == null
            ? null
            : json["numberof_Employees"],
        businessLegalAddress: json["business_legal_address"] == null
            ? null
            : json["business_legal_address"],
        businessGeoLocation: json["business_geo_location"] == null
            ? null
            : BusinessGeoLocation.fromJson(json["business_geo_location"]),
        businessType:
            json["business_type"] == null ? null : json["business_type"],
        isLicensed: json["is_licensed"] == null ? null : json["is_licensed"],
        businessCheck:
            json["business_check"] == null ? null : json["business_check"],
        licensed: json["licensed"] == null
            ? null
            : List<Licensed>.from(
                json["licensed"].map((x) => Licensed.fromJson(x))),
        unlicensed: json["unlicensed"] == null
            ? null
            : List<Licensed>.from(
                json["unlicensed"].map((x) => Licensed.fromJson(x))),
        isWalkin: json["is_walkin"] == null ? null : json["is_walkin"],
        isHome: json["is_home"] == null ? null : json["is_home"],
        isOnDemand: json["is_on_demand"] == null ? null : json["is_on_demand"],
        profileComment:
            json["profile_comment"] == null ? null : json["profile_comment"],
        servicesIds: json["services_ids"] == null
            ? null
            : List<int>.from(json["services_ids"].map((x) => x)),
        services: json["services"] == null
            ? null
            : List<Service>.from(
                json["services"].map((x) => Service.fromJson(x))),
        businessProfilePictures: json["business_profile_pictures"] == null
            ? null
            : List<BusinessProfilePicture>.from(
                json["business_profile_pictures"]
                    .map((x) => BusinessProfilePicture.fromJson(x))),
        bspLicenseAuthorityType: json["bsp_license_authority_type"] == null
            ? null
            : json["bsp_license_authority_type"],
        businessTypes:
            json["business_types"] == null ? null : json["business_types"],
      );

  Map<String, dynamic> toJson() => {
        "business_legal_name":
            businessLegalName == null ? null : businessLegalName,
        "business_phone_number":
            businessPhoneNumber == null ? null : businessPhoneNumber,
        "business_year": businessYear == null ? null : businessYear,
        "numberof_Employees":
            numberofEmployees == null ? null : numberofEmployees,
        "business_legal_address":
            businessLegalAddress == null ? null : businessLegalAddress,
        "business_geo_location":
            businessGeoLocation == null ? null : businessGeoLocation.toJson(),
        "business_type": businessType == null ? null : businessType,
        "is_licensed": isLicensed == null ? null : isLicensed,
        "business_check": businessCheck == null ? null : businessCheck,
        "licensed": licensed == null
            ? null
            : List<dynamic>.from(licensed.map((x) => x.toJson())),
        "unlicensed": unlicensed == null
            ? null
            : List<dynamic>.from(unlicensed.map((x) => x.toJson())),
        "is_walkin": isWalkin == null ? null : isWalkin,
        "is_home": isHome == null ? null : isHome,
        "is_on_demand": isOnDemand == null ? null : isOnDemand,
        "profile_comment": profileComment == null ? null : profileComment,
        "services_ids": servicesIds == null
            ? null
            : List<dynamic>.from(servicesIds.map((x) => x)),
        "services": services == null
            ? null
            : List<dynamic>.from(services.map((x) => x.toJson())),
        "business_profile_pictures": businessProfilePictures == null
            ? null
            : List<dynamic>.from(
                businessProfilePictures.map((x) => x.toJson())),
        "bsp_license_authority_type":
            bspLicenseAuthorityType == null ? null : bspLicenseAuthorityType,
        "business_types": businessTypes == null ? null : businessTypes,
      };
}

class BusinessGeoLocation {
  String lat;
  String lng;

  BusinessGeoLocation({
    this.lat,
    this.lng,
  });

  factory BusinessGeoLocation.fromJson(Map<String, dynamic> json) =>
      BusinessGeoLocation(
        lat: json["lat"] == null ? null : json["lat"],
        lng: json["lng"] == null ? null : json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}

class BusinessProfilePicture {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  BusinessProfilePicture({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });

  factory BusinessProfilePicture.fromJson(Map<String, dynamic> json) =>
      BusinessProfilePicture(
        isUploaded: json["is_uploaded"] == null ? null : json["is_uploaded"],
        uploading: json["uploading"] == null ? null : json["uploading"],
        imageFile: json["image_file"] == null ? null : json["image_file"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "is_uploaded": isUploaded == null ? null : isUploaded,
        "uploading": uploading == null ? null : uploading,
        "image_file": imageFile == null ? null : imageFile,
        "image_url": imageUrl == null ? null : imageUrl,
      };
}

class Licensed {
  String bspLicenseNumber;
  String bspExpiryDate;
  String bspIssuing;
  String bspAuthority;
  List<BusinessProfilePicture> bspLicenseImages;

  Licensed({
    this.bspLicenseNumber,
    this.bspExpiryDate,
    this.bspIssuing,
    this.bspAuthority,
    this.bspLicenseImages,
  });

  factory Licensed.fromJson(Map<String, dynamic> json) => Licensed(
        bspLicenseNumber: json["bsp_license_number"] == null
            ? null
            : json["bsp_license_number"],
        bspExpiryDate:
            json["bsp_expiry_date"] == null ? null : json["bsp_expiry_date"],
        bspIssuing: json["bsp_issuing"] == null ? null : json["bsp_issuing"],
        bspAuthority:
            json["bsp_authority"] == null ? null : json["bsp_authority"],
        bspLicenseImages: json["bsp_license_images"] == null
            ? null
            : List<BusinessProfilePicture>.from(json["bsp_license_images"]
                .map((x) => BusinessProfilePicture.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bsp_license_number":
            bspLicenseNumber == null ? null : bspLicenseNumber,
        "bsp_expiry_date": bspExpiryDate == null ? null : bspExpiryDate,
        "bsp_issuing": bspIssuing == null ? null : bspIssuing,
        "bsp_authority": bspAuthority == null ? null : bspAuthority,
        "bsp_license_images": bspLicenseImages == null
            ? null
            : List<dynamic>.from(bspLicenseImages.map((x) => x.toJson())),
      };
}

class Service {
  String mainCategory;
  int mainCategoryId;
  List<SubCategory> subCategory;

  Service({
    this.mainCategory,
    this.mainCategoryId,
    this.subCategory,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        mainCategory:
            json["main_category"] == null ? null : json["main_category"],
        mainCategoryId:
            json["main_category_id"] == null ? null : json["main_category_id"],
        subCategory: json["sub_category"] == null
            ? null
            : List<SubCategory>.from(
                json["sub_category"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "main_category": mainCategory == null ? null : mainCategory,
        "main_category_id": mainCategoryId == null ? null : mainCategoryId,
        "sub_category": subCategory == null
            ? null
            : List<dynamic>.from(subCategory.map((x) => x.toJson())),
      };
}

class SubCategory {
  String name;
  int id;

  SubCategory({
    this.name,
    this.id,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "id": id == null ? null : id,
      };
}
