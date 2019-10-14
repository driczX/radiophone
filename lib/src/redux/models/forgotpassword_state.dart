import 'package:meta/meta.dart';

import '../models/api_response.dart';

@immutable
class ForgotpasswordState {
  // properties
  final bool isLoading;
  final ApiResponse apiResponse;

  // constructor with default
  ForgotpasswordState({this.isLoading = false, this.apiResponse});

  // allows to modify AuthState parameters while cloning previous ones
  ForgotpasswordState copyWith({bool isLoading, ApiResponse apiResponse}) {
    return new ForgotpasswordState(
      isLoading: isLoading ?? this.isLoading,
      apiResponse: apiResponse ?? this.apiResponse,
    );
  }

  factory ForgotpasswordState.fromJSON(Map<String, dynamic> json) =>
      new ForgotpasswordState(
        isLoading: json['isLoading'],
        apiResponse: json['apiResponse'] == null
            ? null
            : new ApiResponse.fromJson(json['apiResponse']),
      );

  Map<String, dynamic> toJSON() => <String, dynamic>{
        'isLoading': this.isLoading,
        'apiResponse':
            this.apiResponse == null ? null : this.apiResponse.toJson(),
      };

  @override
  String toString() {
    return '''{
                isLoading: $isLoading,
                apiResponse: $apiResponse,                
            }''';
  }
}
