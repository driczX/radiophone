// import 'package:redux/redux.dart';

// import '../actions/signup_actions.dart';
// import '../models/signup_state.dart';

// Reducer<SignupState> signupReducer = combineReducers([
//   new TypedReducer<SignupState, UserSignupRequest>(userSignupRequestReducer),
//   new TypedReducer<SignupState, UserSignupSuccessRequest>(
//       userSignupSuccessReducer),
//   new TypedReducer<SignupState, UserSignupFailureRequest>(
//       userSignupFailureReducer),
// ]);

// SignupState userSignupRequestReducer(
//     SignupState signup, UserSignupRequest action) {
//   return signup.copyWith(
//     isLoading: true,
//   );
// }

// SignupState userSignupSuccessReducer(
//     SignupState signup, UserSignupSuccessRequest action) {
//   return signup.copyWith(
//     isLoading: false,
//     error: null,
//     signupUser: action.signupUser,
//   );
// }

// SignupState userSignupFailureReducer(
//     SignupState signup, UserSignupFailureRequest action) {
//   return signup.copyWith(
//     isLoading: false,
//     error: action.error,
//     signupUser: null,
//   );
// }
