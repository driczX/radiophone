import 'package:meta/meta.dart';
import '../models/auth_state.dart';
import '../models/signup_state.dart';
import '../models/forgotpassword_state.dart';

@immutable
class AppState {
  final AuthState auth;
  final SignupState signup;
  final ForgotpasswordState forgotpassword;

  AppState({
    AuthState auth,
    SignupState signup,
    ForgotpasswordState forgotpassword,
  })  : auth = auth ?? new AuthState(),
        signup = signup ?? new SignupState(),
        forgotpassword = forgotpassword ?? new ForgotpasswordState();

  static AppState rehydrationJSON(dynamic json) => new AppState(
        auth: new AuthState.fromJSON(json['auth']),
        signup: new SignupState.fromJSON(json['signup']),
        forgotpassword: new ForgotpasswordState.fromJSON(
          json['forgotpassword'],
        ),
      );

  Map<String, dynamic> toJson() => {
        'auth': auth.toJSON(),
        'signup': signup.toJSON(),
        'forgotpassword': forgotpassword.toJSON(),
      };

  AppState copyWith({
    bool rehydrated,
    AuthState auth,
    SignupState signup,
    ForgotpasswordState forgotpassword,
  }) {
    return new AppState(
      auth: auth ?? this.auth,
      signup: signup ?? this.signup,
      forgotpassword: forgotpassword ?? this.forgotpassword,
    );
  }

  @override
  String toString() {
    return '''AppState{
            auth: $auth,
            signup: $signup,
            forgotpassword: $forgotpassword,
            
        }''';
  }
}
