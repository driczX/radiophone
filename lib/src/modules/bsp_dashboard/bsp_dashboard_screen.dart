import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tudo/src/redux/models/app_state.dart';
import 'package:tudo/src/redux/models/login_user.dart';

class BspDashboardTab extends StatefulWidget {
  @override
  _BspDashboardTabState createState() => _BspDashboardTabState();
}

class _BspDashboardTabState extends State<BspDashboardTab> {
  bool _isBSPDialogShow = false;
  bool _isConfrimationPending = false;
  bool hasError = false;
  bool hasTimerStopped = false;
  String passcode = '';

  String _loginUserEmail = '';
  TextEditingController controller = TextEditingController();
  int _timerSecs = 300;
  int pinLength = 6;
  String thisText = "";

  @override
  void initState() {
    super.initState();
  }

  Widget content(context, cmrDashboardVm) {
    return Container(
      color: Colors.amber,
      // backgroundColor: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            color: Colors.amber,
            // margin: EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              children: <Widget>[
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                  // mainAxisSpacing: ,

                  mainAxisSpacing: 10.0,
                  // crossAxisSpacing: 5.0,
                  children: List.generate(8, (index) {
                    switch (index) {
                      case 0:
                        return Container(
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: Icon(
                                      Icons.done_all,
                                      color: Colors.black,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                  Text(
                                    'Scheduled',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.width / 150,
                                right: MediaQuery.of(context).size.width / 30,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "12",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // margin: EdgeInsets.only(top: 30, left: 40),
                        );

                        break;
                      case 1:
                        return Container(
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      print("Hello");
                                    },
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                  ),
                                  Text(
                                    'EvenTer',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.width / 150,
                                right: MediaQuery.of(context).size.width / 30,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "55",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // margin: EdgeInsets.only(top: 30, left: 40),
                        );
                        break;
                      case 2:
                        return Container(
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      child: Icon(
                                        Icons.music_note,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                  ),
                                  Text(
                                    'Hanging',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.width / 150,
                                right: MediaQuery.of(context).size.width / 30,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "34",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // margin: EdgeInsets.only(top: 30, left: 40),
                        );

                        break;
                      case 3:
                        return Container(
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: Icon(
                                      Icons.cloud,
                                      color: Colors.black,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                  Text(
                                    'MyNet',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.width / 150,
                                right: MediaQuery.of(context).size.width / 30,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "55",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // margin: EdgeInsets.only(top: 30, left: 40),
                        );

                        break;
                      case 4:
                        return Container(
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: Icon(Icons.description,
                                        color: Colors.black),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                  Text(
                                    'NTer',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.width / 150,
                                right: MediaQuery.of(context).size.width / 30,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "90",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // margin: EdgeInsets.only(top: 30, left: 40),
                        );

                        break;
                      case 5:
                        return Container(
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                  Text(
                                    'Payments',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.width / 150,
                                right: MediaQuery.of(context).size.width / 30,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "1",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // margin: EdgeInsets.only(top: 30, left: 40),
                        );

                        break;
                      case 6:
                        return Container(
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: Icon(
                                      Icons.games,
                                      color: Colors.white,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                  Text(
                                    'Reports',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.width / 150,
                                right: MediaQuery.of(context).size.width / 30,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "43",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // margin: EdgeInsets.only(top: 30, left: 40),
                        );

                        break;
                      case 7:
                        return Container(
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: Icon(
                                      Icons.cached,
                                      color: Colors.black,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                  Text(
                                    'Schedule',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.width / 150,
                                right: MediaQuery.of(context).size.width / 30,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "23",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // margin: EdgeInsets.only(top: 30, left: 40),
                        );

                        break;
                      case 8:
                        return Container(
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: Icon(
                                      Icons.delete,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xfffcb127),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                  ),
                                  Text(
                                    'Bin',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.width / 150,
                                right: MediaQuery.of(context).size.width / 30,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "11",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // margin: EdgeInsets.only(top: 30, left: 40),
                        );

                        break;
                    }
                  }),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: StoreConnector<AppState, CMRDashboardViewModel>(
        converter: (Store<AppState> store) =>
            CMRDashboardViewModel.fromStore(store),
        onInit: (Store<AppState> store) {
          print('I will be called when this components loads');
          if (store.state.auth.loginUser != null) {
            print(store.state.auth.loginUser.user.statusId);
            String confirmationStatus =
                store.state.auth.loginUser.user.statusId;
            _loginUserEmail = store.state.auth.loginUser.user.email;
            print(
                'store.state.auth.loginUser.user = ${store.state.auth.loginUser.user.toJson()}');
            print('user email');
            print(_loginUserEmail);
            int signInCount =
                (store.state.auth.loginUser.user.signInCount == null)
                    ? 0
                    : store.state.auth.loginUser.user.signInCount;
            if (confirmationStatus == 'confirmation_pending') {
              _isConfrimationPending = true;
            }
            print(signInCount);
            signInCount = 0;
            if (signInCount == 0) {
              _isBSPDialogShow = true;
            }
          } else {
            // _isConfrimationPending = true;
            _isBSPDialogShow = true;
          }
          return store.state.auth.loginUser;
        },
        builder: (BuildContext context, CMRDashboardViewModel cmrDashboardVm) =>
            content(context, cmrDashboardVm),
      ),
    );
  }
}

class CMRDashboardViewModel {
  final String error;
  final LoginUser loginUser;
  CMRDashboardViewModel({
    this.error,
    this.loginUser,
  });

  static CMRDashboardViewModel fromStore(Store<AppState> store) {
    return CMRDashboardViewModel(
      error: store.state.auth.error,
      loginUser: store.state.auth.loginUser == null
          ? null
          : store.state.auth.loginUser,
    );
  }
}
