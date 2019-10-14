// import 'package:redux_persist/redux_persist.dart';

import 'package:tudo/src/redux/reducers/signup_reducer.dart';

import '../models/app_state.dart';
import '../reducers/auth_reducer.dart';

AppState appReducer(AppState state, action) {
  // if (action is LoadAction<AppState>) {
  //   return action.state ?? state;
  // } else {
  return new AppState(
    auth: authReducer(state.auth, action),
    
  );
  // }
}
