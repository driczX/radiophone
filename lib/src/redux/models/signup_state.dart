import 'package:meta/meta.dart';
import 'package:tudo/src/redux/models/signup_user.dart';


@immutable
class SignupState {
  // properties
  final bool isLoading;
  final SignupUser signupUser;
  final String error;

  // constructor with default
  SignupState({this.isLoading = false, this.signupUser, this.error});

  // allows to modify AuthState parameters while cloning previous ones
  SignupState copyWith({bool isLoading, String error, SignupUser signupUser}) {
    return new SignupState(
      isLoading: isLoading ?? this.isLoading,
      signupUser: signupUser ?? this.signupUser,
      error: error ?? this.error,
    );
  }

  factory SignupState.fromJSON(Map<String, dynamic> json) => new SignupState(
        isLoading: json['isLoading'],
        error: json['error'],
        signupUser: json['signupUser'] == null
            ? null
            : new SignupUser.fromJson(json['signupUser']),
      );

  Map<String, dynamic> toJSON() => <String, dynamic>{
        'isLoading': this.isLoading,
        'error': this.error,
        'signupUser': this.signupUser == null ? null : this.signupUser.toJson(),
      };

  @override
  String toString() {
    return '''{
                isLoading: $isLoading,
                error: $error,
                signupUser: $signupUser
            }''';
  }
}
