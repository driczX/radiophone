import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tudo/src/redux/actions/auth_actions.dart';
import 'package:tudo/src/redux/actions/startup_action.dart';
import 'package:tudo/src/redux/models/app_state.dart';
import 'package:tudo/src/redux/models/login_user.dart';
import 'package:tudo/src/redux/reducers/app_reducers.dart';
import 'package:tudo/src/redux/middleware/middleware.dart';

Store<AppState> createStore() {
  Store<AppState> store = new Store(
    appReducer,
    initialState: new AppState(),
    middleware: createMiddleware(),
    syncStream: true,
    distinct: false,
  );
  persistor.load().then((value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userString = preferences.getString('user');
    bool isRemember = preferences.getBool('rememberMe');
    if (userString != null && isRemember != null && isRemember == true) {
      LoginUser userModel = loginUserFromJson(userString);
      String token = userModel.token;
      store.dispatch(
        new UserLoginSuccess(
          userModel,
          token,
          false,
        ),
      );
    } else {
      store.dispatch(StartupAction());
    }
  });
  return store;
}
