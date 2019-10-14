// To parse this JSON data, do
//
//     final loginUser = loginUserFromJson(jsonString);

import 'dart:convert';

LoginUser loginUserFromJson(String str) => LoginUser.fromJson(json.decode(str));

String loginUserToJson(LoginUser data) => json.encode(data.toJson());

class LoginUser {
  String token;
  User user;

  LoginUser({
    this.token,
    this.user,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
        token: json["token"] == null ? null : json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "user": user == null ? null : user.toJson(),
      };
}

class User {
  DateTime confirmationSentAt;
  String confirmationToken;
  DateTime confirmedAt;
  Country country;
  DateTime currentSignInAt;
  String email;
  int failedAttempts;
  String id;
  bool isBsp;
  bool isVerified;
  Language language;
  DateTime lockedAt;
  dynamic meta;
  String mobile;
  int platformTermsAndConditionId;
  Profile profile;
  DateTime resetPasswordSentAt;
  String resetPasswordToken;
  dynamic scopes;
  int signInCount;
  String statusId;
  String token;
  String unlockToken;

  User({
    this.confirmationSentAt,
    this.confirmationToken,
    this.confirmedAt,
    this.country,
    this.currentSignInAt,
    this.email,
    this.failedAttempts,
    this.id,
    this.isBsp,
    this.isVerified,
    this.language,
    this.lockedAt,
    this.meta,
    this.mobile,
    this.platformTermsAndConditionId,
    this.profile,
    this.resetPasswordSentAt,
    this.resetPasswordToken,
    this.scopes,
    this.signInCount,
    this.statusId,
    this.token,
    this.unlockToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        confirmationSentAt: json["confirmationSentAt"] == null
            ? null
            : DateTime.parse(json["confirmationSentAt"]),
        confirmationToken: json["confirmationToken"] == null
            ? null
            : json["confirmationToken"],
        confirmedAt: json["confirmedAt"] == null
            ? null
            : DateTime.parse(json["confirmedAt"]),
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        currentSignInAt: json["currentSignInAt"] == null
            ? null
            : DateTime.parse(json["currentSignInAt"]),
        email: json["email"] == null ? null : json["email"],
        failedAttempts:
            json["failedAttempts"] == null ? null : json["failedAttempts"],
        id: json["id"] == null ? null : json["id"],
        isBsp: json["isBsp"] == null ? null : json["isBsp"],
        isVerified: json["isVerified"] == null ? null : json["isVerified"],
        language: json["language"] == null
            ? null
            : Language.fromJson(json["language"]),
        lockedAt:
            json["lockedAt"] == null ? null : DateTime.parse(json["lockedAt"]),
        meta: json["meta"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        platformTermsAndConditionId: json["platformTermsAndConditionId"] == null
            ? null
            : json["platformTermsAndConditionId"],
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
        resetPasswordSentAt: json["resetPasswordSentAt"] == null
            ? null
            : DateTime.parse(json["resetPasswordSentAt"]),
        resetPasswordToken: json["resetPasswordToken"] == null
            ? null
            : json["resetPasswordToken"],
        scopes: json["scopes"],
        signInCount: json["signInCount"] == null ? null : json["signInCount"],
        statusId: json["statusId"] == null ? null : json["statusId"],
        token: json["token"] == null ? null : json["token"],
        unlockToken: json["unlockToken"] == null ? null : json["unlockToken"],
      );

  Map<String, dynamic> toJson() => {
        "confirmationSentAt": confirmationSentAt == null
            ? null
            : confirmationSentAt.toIso8601String(),
        "confirmationToken":
            confirmationToken == null ? null : confirmationToken,
        "confirmedAt":
            confirmedAt == null ? null : confirmedAt.toIso8601String(),
        "country": country == null ? null : country.toJson(),
        "currentSignInAt":
            currentSignInAt == null ? null : currentSignInAt.toIso8601String(),
        "email": email == null ? null : email,
        "failedAttempts": failedAttempts == null ? null : failedAttempts,
        "id": id == null ? null : id,
        "isBsp": isBsp == null ? null : isBsp,
        "isVerified": isVerified == null ? null : isVerified,
        "language": language == null ? null : language.toJson(),
        "lockedAt": lockedAt == null ? null : lockedAt.toIso8601String(),
        "meta": meta,
        "mobile": mobile == null ? null : mobile,
        "platformTermsAndConditionId": platformTermsAndConditionId == null
            ? null
            : platformTermsAndConditionId,
        "profile": profile == null ? null : profile.toJson(),
        "resetPasswordSentAt": resetPasswordSentAt == null
            ? null
            : resetPasswordSentAt.toIso8601String(),
        "resetPasswordToken":
            resetPasswordToken == null ? null : resetPasswordToken,
        "scopes": scopes,
        "signInCount": signInCount == null ? null : signInCount,
        "statusId": statusId == null ? null : statusId,
        "token": token == null ? null : token,
        "unlockToken": unlockToken == null ? null : unlockToken,
      };
}

class Country {
  String capital;
  String code;
  dynamic contactInfo;
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
        contactInfo: json["contactInfo"],
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
        "contactInfo": contactInfo,
        "currencyCode": currencyCode == null ? null : currencyCode,
        "currencySymbol": currencySymbol == null ? null : currencySymbol,
        "id": id == null ? null : id,
        "isdCode": isdCode == null ? null : isdCode,
        "name": name == null ? null : name,
        "officialName": officialName == null ? null : officialName,
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

class Profile {
  String firstName;
  String lastName;

  Profile({
    this.firstName,
    this.lastName,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
      };
}
