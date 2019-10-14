import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:tudo/src/redux/models/login_user.dart';
import 'package:tudo/src/utils/navigation_helper.dart';

import '../models/app_state.dart';

class UserLoginRequest {}

class UserLoginSuccess {
  final LoginUser loginUser;
  final String token;
  final bool isBspMode;

  UserLoginSuccess(this.loginUser, this.token, this.isBspMode);
}

class UserLoginFailure {
  final String error;

  UserLoginFailure(this.error);
}

class UserLogout {}

final Function login = (BuildContext context, LoginUser loginUser) {
  return (Store<AppState> store) async {
    store.dispatch(
      new UserLoginSuccess(loginUser, loginUser.token, false),
    );
    // NavigationHelper.navigatetoMainscreen(context);
  };
};

final Function logout = (BuildContext context) {
  return (Store<AppState> store) {
    store.dispatch(
      new UserLogout(),
    );
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
  };
};
