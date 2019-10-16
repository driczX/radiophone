import 'dart:io';

import 'package:graphql/client.dart';
import 'package:tudo/src/utils/gql_strings.dart';
import 'package:tudo/src/utils/graphql_helper.dart';

class LoginRepository {
  LoginRepository();

  void test() {
    print('login repository');
  }

  Future<dynamic> loginUser(String email, String pass) async {
    Map<String, dynamic> user = {
      "user": {
        "deviceToken": "abc",
        "deviceType": Platform.operatingSystem,
        "email": email,
        "password": pass
      }
    };

    try {
      final QueryResult result =
          await GraphQLHelper.gqlMutation(GQLStrings.loginUser(), user);
      print(result.data);
      // Handle the error
      Map<String, dynamic> userRes = {
        'data': result.data,
        'error': result.errors
      };
      return userRes;
    } catch (e) {}
  }
}
