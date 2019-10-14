import 'package:flutter/material.dart';

import 'package:tudo/src/redux/models/api_response.dart';

class UserforgotpasswordRequest {}

class UserforgotpasswordSuccessRequest {
  final ApiResponse apiResponse;
  UserforgotpasswordSuccessRequest(this.apiResponse);
}

class UserforgotpasswordFailureRequest {
  final ApiResponse apiResponse;
  UserforgotpasswordFailureRequest(this.apiResponse);
}

final Function forgotpassword = (BuildContext context, String email) {};
