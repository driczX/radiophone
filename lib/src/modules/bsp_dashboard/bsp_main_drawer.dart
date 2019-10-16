import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tudo/src/modules/bsp_dashboard/business_setting.dart';
import 'package:tudo/src/modules/cmr_dashboard/cmr_main_screen.dart';
import 'package:tudo/src/redux/actions/auth_actions.dart';
import 'package:tudo/src/redux/models/app_state.dart';
import 'package:tudo/src/redux/models/login_user.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/app_constants_value.dart';

class BspMainDrawer extends StatefulWidget {
  BspMainDrawer({Key key}) : super(key: key);
  _BspMainDrawerState createState() => _BspMainDrawerState();
}

class _BspMainDrawerState extends State<BspMainDrawer> {
  Widget content(context, mainDrawerVM) {
    // final String username = mainDrawerVM.user.profile;
    print(mainDrawerVM.user);
    return new Drawer(
      elevation: 20.0,
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            // padding: const EdgeInsets.only(left: 16.0, right: 40),
            decoration: BoxDecoration(
                color: colorStyles["primary"],
                boxShadow: [BoxShadow(color: Colors.black45)]),
            width: 300,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.remove('user');
                          mainDrawerVM.logoutMe(context);
                        },
                      ),
                    ),
                    Container(
                      height: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: new AssetImage("assets/user.png"),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    new Text(
                      mainDrawerVM.user != null
                          ? "${mainDrawerVM.user.user.profile.firstName} ${mainDrawerVM.user.user.profile.lastName}"
                          : "Demo",
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),

          new ListTile(
            leading: new Icon(Icons.dashboard),
            title: new Text(AppConstantsValue.appConst['maindrawer']
                ['dashboard']['translation']),
            onTap: () {},
          ),
          // => print('you pressed support')),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.dashcube),
            title: Text("Business Dashboard"),
            onTap: () => print('you pressed Setting'),
          ),
          new ListTile(
              leading: new Icon(Icons.settings),
              title: Text("Business Settings"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BusinessSetting()));
              }),
          new ListTile(
              leading: new Icon(Icons.swap_vertical_circle),
              title: Text("Switch Consumer Mode"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              }),
          new ListTile(
            leading: new Icon(Icons.notifications),
            title: Text("Notification Prefernces"),
            onTap: () => print('you pressed Setting'),
          ),
          new ListTile(
            leading: new Icon(Icons.contacts),
            title: Text("Contact US"),
            onTap: () => print('you pressed T&C'),
          ),
          new ListTile(
              leading: new Icon(Icons.info),
              title: Text("Refer TUDO"),
              onTap: () {}),
          new ListTile(
              leading: new Icon(Icons.note),
              title: Text("Legal Terms and Condition"),
              onTap: () {}),
          new Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, MainDrawerViewModel>(
      converter: (Store<AppState> store) =>
          MainDrawerViewModel.fromStore(store),
      builder: (BuildContext context, MainDrawerViewModel mainDrawerVM) =>
          content(context, mainDrawerVM),
    );
  }
}

class MainDrawerViewModel {
  final LoginUser user;
  final Function(BuildContext context) logoutMe;
  final Function(BuildContext context, String usermode) changeMode;
  MainDrawerViewModel({this.logoutMe, this.user, this.changeMode});

  static MainDrawerViewModel fromStore(Store<AppState> store) {
    return MainDrawerViewModel(
      user: store.state.auth.loginUser,
      logoutMe: (context) {
        store.dispatch(logout(context));
      },
    );
  }
}
