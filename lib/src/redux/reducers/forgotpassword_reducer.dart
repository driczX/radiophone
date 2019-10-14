import 'package:redux/redux.dart';

import '../actions/forgotpassword_actions.dart';
import '../models/forgotpassword_state.dart';

Reducer<ForgotpasswordState> forgotpasswordReducer = combineReducers([
  new TypedReducer<ForgotpasswordState, UserforgotpasswordRequest>(
      userforgotpasswordRequestReducer),
  new TypedReducer<ForgotpasswordState, UserforgotpasswordSuccessRequest>(
      userforgotpasswordSuccessReducer),
  new TypedReducer<ForgotpasswordState, UserforgotpasswordFailureRequest>(
      userforgotpasswordFailureReducer),
]);

ForgotpasswordState userforgotpasswordRequestReducer(
    ForgotpasswordState forgotpassword, UserforgotpasswordRequest action) {
  return forgotpassword.copyWith(isLoading: true);
}

ForgotpasswordState userforgotpasswordSuccessReducer(
    ForgotpasswordState forgotpassword,
    UserforgotpasswordSuccessRequest action) {
  return forgotpassword.copyWith(
      isLoading: false, apiResponse: action.apiResponse);
}

ForgotpasswordState userforgotpasswordFailureReducer(
    ForgotpasswordState forgotpassword,
    UserforgotpasswordFailureRequest action) {
  return forgotpassword.copyWith(
      isLoading: false, apiResponse: action.apiResponse);
}
