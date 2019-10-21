import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tudo/src/redux/actions/auth_actions.dart';
import 'package:tudo/src/redux/models/app_state.dart';
import 'package:tudo/src/redux/models/login_user.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/app_constants_value.dart';
import 'package:tudo/src/utils/navigation_helper.dart';

class MainDrawer extends StatefulWidget {
  MainDrawer({Key key}) : super(key: key);
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
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
            onTap: () {
              // if (mainDrawerVM.userMode != 'bsp') {
              //   mainDrawerVM.changeMode(context, 'cmr');
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => MainScreen(),
              //   ),
              // );
              // } else {
              //   mainDrawerVM.changeMode(context, 'bsp');
              //   Navigator.pushNamed(context, '/bspmainscreen');
              // }
            },
          ),
          // => print('you pressed support')),
          new ListTile(
            leading: new Icon(Icons.settings),
            title: new Text(AppConstantsValue.appConst['maindrawer']['setting']
                ['translation']),
            onTap: () => print('you pressed Setting'),
          ),
          new ListTile(
              leading: new Icon(Icons.room_service),
              title: new Text(AppConstantsValue.appConst['maindrawer']
                  ['BusinessServiceProvider']['translation']),
              onTap: () {
                print('you pressed Bsp Flow turn on');
                NavigationHelper.navigatetoBspsignupcreen(context);
              }),
          new ListTile(
            leading: new Icon(Icons.notifications),
            title: new Text(AppConstantsValue.appConst['maindrawer']
                ['Notification']['translation']),
            onTap: () => print('you pressed Setting'),
          ),
          new ListTile(
            leading: new Icon(Icons.apps),
            title: new Text(AppConstantsValue.appConst['maindrawer']['TUDO']
                ['translation']),
            onTap: () => print('you pressed Setting'),
          ),
          new ListTile(
            leading: new Icon(Icons.event_note),
            title: new Text(AppConstantsValue.appConst['maindrawer']
                ['termsandcondition']['translation']),
            onTap: () => print('you pressed T&C'),
          ),
          new ListTile(
              leading: new Icon(Icons.contacts),
              title: new Text(AppConstantsValue.appConst['maindrawer']
                  ['contactus']['translation']),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Addwalkinservice(),
                //   ),
                // );
              }),
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
