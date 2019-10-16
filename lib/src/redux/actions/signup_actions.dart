import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:tudo/src/modules/signup/signup_repository.dart';
import 'package:tudo/src/modules/signup/signup_screen.dart';
import 'package:tudo/src/redux/models/app_state.dart';
import 'package:tudo/src/redux/models/login_user.dart';
import 'package:tudo/src/redux/models/signup_user.dart';
import 'package:tudo/src/utils/navigation_helper.dart';

import 'auth_actions.dart';

class UserSignupRequest {}

class VerifyOTPRequest {}

class UserSignupSuccessRequest {
  final SignupUser signupUser;
  UserSignupSuccessRequest(this.signupUser);
}

class UserSignupFailureRequest {
  final String error;
  UserSignupFailureRequest(this.error);
}

final Function signup = (BuildContext context, Person person) {
  print('person');
  print(person.country);

  return (Store<AppState> store) async {
    store.dispatch(new UserSignupRequest());
    try {
      Map<String, dynamic> signUpUserMap = {
        'email': person.email,
        'password': person.password,
        'phoneNumber': person.phoneNumber,
        'firstName': person.firstname,
        'lastName': person.lastname,
      };
      SignupRepository _signupRepository = SignupRepository();
      SignupUser user = await _signupRepository.signupUser(signUpUserMap);
      return store.dispatch(
        new UserSignupSuccessRequest(user),
      );
    } catch (e) {
      print('error');
      print(e);
      return store.dispatch(
        new UserSignupFailureRequest('User already exist!'),
      );
    }
  };
};

final Function loginUserFirstTime = (BuildContext context, LoginUser user) {
  return (Store<AppState> store) async {
    store.dispatch(
      new UserLoginSuccess(user, user.token, false),
    );
    NavigationHelper.navigatetoMainscreen(context);
  };
};
