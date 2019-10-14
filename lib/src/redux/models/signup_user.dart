// To parse this JSON data, do
//
//     final signupUser = signupUserFromJson(jsonString);

import 'dart:convert';

SignupUser signupUserFromJson(String str) =>
    SignupUser.fromJson(json.decode(str));

String signupUserToJson(SignupUser data) => json.encode(data.toJson());

class SignupUser {
  int businessId;
  DateTime confirmationSentAt;
  String confirmationToken;
  DateTime currentSignInAt;
  String email;
  int failedAttempts;
  String id;
  bool isVerified;
  DateTime lockedAt;
  String mobile;
  int platformTermsAndConditionId;
  Profile profile;
  DateTime resetPasswordSentAt;
  String resetPasswordToken;
  dynamic scopes;
  int singnInCount;
  String statusId;
  String token;
  DateTime unlockToken;

  SignupUser({
    this.businessId,
    this.confirmationSentAt,
    this.confirmationToken,
    this.currentSignInAt,
    this.email,
    this.failedAttempts,
    this.id,
    this.isVerified,
    this.lockedAt,
    this.mobile,
    this.platformTermsAndConditionId,
    this.profile,
    this.resetPasswordSentAt,
    this.resetPasswordToken,
    this.scopes,
    this.singnInCount,
    this.statusId,
    this.token,
    this.unlockToken,
  });

  factory SignupUser.fromJson(Map<String, dynamic> json) => SignupUser(
        businessId: json["businessId"] == null ? null : json["businessId"],
        confirmationSentAt: json["confirmationSentAt"] == null
            ? null
            : DateTime.parse(json["confirmationSentAt"]),
        confirmationToken: json["confirmationToken"] == null
            ? null
            : json["confirmationToken"],
        currentSignInAt: json["currentSignInAt"] == null
            ? null
            : DateTime.parse(json["currentSignInAt"]),
        email: json["email"] == null ? null : json["email"],
        failedAttempts:
            json["failedAttempts"] == null ? null : json["failedAttempts"],
        id: json["id"] == null ? null : json["id"],
        isVerified: json["isVerified"] == null ? null : json["isVerified"],
        lockedAt:
            json["lockedAt"] == null ? null : DateTime.parse(json["lockedAt"]),
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
        singnInCount:
            json["singnInCount"] == null ? null : json["singnInCount"],
        statusId: json["statusId"] == null ? null : json["statusId"],
        token: json["token"] == null ? null : json["token"],
        unlockToken: json["unlockToken"] == null
            ? null
            : DateTime.parse(json["unlockToken"]),
      );

  Map<String, dynamic> toJson() => {
        "businessId": businessId == null ? null : businessId,
        "confirmationSentAt": confirmationSentAt == null
            ? null
            : confirmationSentAt.toIso8601String(),
        "confirmationToken":
            confirmationToken == null ? null : confirmationToken,
        "currentSignInAt":
            currentSignInAt == null ? null : currentSignInAt.toIso8601String(),
        "email": email == null ? null : email,
        "failedAttempts": failedAttempts == null ? null : failedAttempts,
        "id": id == null ? null : id,
        "isVerified": isVerified == null ? null : isVerified,
        "lockedAt": lockedAt == null ? null : lockedAt.toIso8601String(),
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
        "singnInCount": singnInCount == null ? null : singnInCount,
        "statusId": statusId == null ? null : statusId,
        "token": token == null ? null : token,
        "unlockToken":
            unlockToken == null ? null : unlockToken.toIso8601String(),
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
