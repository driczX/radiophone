import 'package:redux/redux.dart';

import '../actions/auth_actions.dart';
import '../models/auth_state.dart';

Reducer<AuthState> authReducer = combineReducers([
  new TypedReducer<AuthState, UserLoginRequest>(userLoginRequestReducer),
  new TypedReducer<AuthState, UserLoginSuccess>(userLoginSuccessReducer),
  new TypedReducer<AuthState, UserLoginFailure>(userLoginFailureReducer),
  new TypedReducer<AuthState, UserLogout>(userLogoutReducer),
]);

AuthState userLoginRequestReducer(AuthState auth, UserLoginRequest action) {
  return auth.copyWith(
    isAuthenticated: false,
    isAuthenticating: true,
  );
}

AuthState userLoginSuccessReducer(AuthState auth, UserLoginSuccess action) {
  return auth.copyWith(
    isAuthenticated: true,
    isAuthenticating: false,
    loginUser: action.loginUser,
    token: action.token,
    error: null,
  );
}

AuthState userLoginFailureReducer(AuthState auth, UserLoginFailure action) {
  return auth.copyWith(
    isAuthenticated: false,
    isAuthenticating: false,
    loginUser: null,
    token: null,
    error: action.error,
  );
}

AuthState userLogoutReducer(AuthState auth, UserLogout action) {
  return new AuthState();
}
