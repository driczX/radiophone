import 'package:meta/meta.dart';
import 'package:tudo/src/redux/models/login_user.dart';

@immutable
class AuthState {
  // properties
  final bool isAuthenticated;
  final bool isAuthenticating;
  final LoginUser loginUser;
  final String token;
  final String error;

  // constructor with default
  AuthState({
    this.isAuthenticated = false,
    this.isAuthenticating = false,
    this.token,
    this.loginUser,
    this.error,
  });
  // allows to modify AuthState parameters while cloning previous ones
  AuthState copyWith({
    bool isAuthenticated,
    bool isAuthenticating,
    String error,
    String token,
    LoginUser loginUser,
  }) {
    return new AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
      error: error ?? this.error,
      token: token ?? this.token,
      loginUser: loginUser ?? this.loginUser,
    );
  }

  factory AuthState.fromJSON(Map<String, dynamic> json) => new AuthState(
        isAuthenticated: json['isAuthenticated'],
        isAuthenticating: json['isAuthenticating'],
        error: json['error'],
        token: json['token'],
        loginUser: json['user'] == null
            ? null
            : new LoginUser.fromJson(
                json['loginUser'],
              ),
      );

  Map<String, dynamic> toJSON() => <String, dynamic>{
        'isAuthenticated': this.isAuthenticated,
        'isAuthenticating': this.isAuthenticating,
        'loginUser': this.loginUser == null ? null : this.loginUser.toJson(),
        'error': this.error,
        'token': this.token,
      };

  @override
  String toString() {
    return '''{
                isAuthenticated: $isAuthenticated,
                isAuthenticating: $isAuthenticating,
                loginUser: $loginUser,
                error: $error,
                token: $token,
            }''';
  }
}
