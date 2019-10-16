import 'dart:convert';
import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tudo/src/modules/signup/model/countries.dart';
import 'package:tudo/src/modules/signup/model/termsandcondition.dart';
import 'package:tudo/src/utils/gql_strings.dart';
import 'package:tudo/src/utils/graphql_helper.dart';

class SignupRepository {
  SignupRepository();
  Future<dynamic> signupUser(Map<String, dynamic> signUpUserMap) async {
    SharedPreferences devicepref = await SharedPreferences.getInstance();
    String stringdevice = devicepref.getString('deviceinfo');
    Map devicevalue = jsonDecode(stringdevice);
    print("DEVICE");
    print(stringdevice);
    print(devicevalue['id']);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userLangId = pref.getString('user_lang_id') == null
        ? '1'
        : pref.getString('user_lang_id');
    Map<String, dynamic> signupUserRequestMap = {
      "user": {
        "email": signUpUserMap['email'],
        "password": signUpUserMap['password'],
        "mobile": signUpUserMap['phoneNumber'],
        "statusId": "confirmation_pending",
        "languageId": int.parse(userLangId),
        "countryId": int.parse(signUpUserMap['countryId']),
        "profile": {
          "firstName": signUpUserMap['firstName'],
          "lastName": signUpUserMap['lastName'],
        },
        "install": {
          "os": Platform.operatingSystem,
          "deviceInfo": {
            "device": devicevalue['device'],
            "manufacture": devicevalue['manufacturer']
          },
          "deviceToken": "34214324213413423421",
          "fcmToken": "1234234234231423421423424234123"
        }
      }
    };
    print(signupUserRequestMap);
    final QueryResult result = await GraphQLHelper.gqlMutation(
        GQLStrings.signupUser(), signupUserRequestMap);
    Map<String, dynamic> signupResponse = {
      'data': result.data,
      'error': result.errors
    };
    return signupResponse;
  }

  Future<dynamic> getCountries() async {
    try {
      final QueryResult result =
          await GraphQLHelper.gqlQuery(GQLStrings.getCountries(), {});
      Countries countries = Countries.fromJson(result.data);
      return countries;
    } catch (e) {}
  }

  Future<dynamic> getTermsandCondition() async {
    try {
      final QueryResult result =
          await GraphQLHelper.gqlQuery(GQLStrings.getTermsandCondition(), {});
      TermsandCondition termsandCondition =
          TermsandCondition.fromJson(result.data);
      return termsandCondition;
    } catch (e) {}
  }

  Future<Map<String, dynamic>> activateUser(String email, String code) async {
    final QueryResult result = await GraphQLHelper.gqlQuery(
      GQLStrings.validateUser(),
      {
        "user": {
          "email": email,
          "token": int.parse(code),
        }
      },
    );
    print('result of actication');
    print(result.data);
    print(result.errors);
    Map<String, dynamic> activationResponse = {
      'data': result.data,
      'error': result.errors
    };
    return activationResponse;
  }

  Future<dynamic> resendToken(String email, String purpose) async {
    Map<String, dynamic> resendTokenMap = {
      "token": {
        "deviceToken": "abc",
        "deviceType": Platform.operatingSystem,
        "email": email,
        "purpose": purpose
      }
    };
    final QueryResult result = await GraphQLHelper.gqlMutation(
      GQLStrings.resendToken(),
      resendTokenMap,
    );
    Map<String, dynamic> resendTokenResponse = {
      'data': result.data,
      'error': result.errors
    };
    print('resendTokenResponse');
    print(resendTokenResponse);
    return resendTokenResponse;
  }
}
