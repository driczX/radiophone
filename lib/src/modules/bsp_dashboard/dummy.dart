// import 'dart:async';

// import 'package:after_layout/after_layout.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:tudo/src/utils/navigation_helper.dart';
// import 'package:tudo/src/widgets/tudo_custom_widget/TudoConditionDialog.dart';
// import 'package:pin_code_text_field/pin_code_text_field.dart';
// import 'package:redux/redux.dart';
// import 'package:flutter_redux/flutter_redux.dart';

// import 'package:tudo/src/modules/signup/signup_repository.dart';
// import 'package:tudo/src/redux/models/app_state.dart';
// import 'package:tudo/src/redux/models/login_user.dart';
// import 'package:tudo/src/styles/colors.dart';
// import 'package:tudo/src/widgets/tudo_custom_widget/TudoTimerDialogWidget.dart';

// class BspDashboardTab extends StatefulWidget {
//   @override
//   _BspDashboardTabState createState() => _BspDashboardTabState();
// }

// class _BspDashboardTabState extends State<BspDashboardTab>
//     with AfterLayoutMixin<BspDashboardTab> {
//   bool _isBSPDialogShow = false;
//   bool _isConfrimationPending = false;
//   bool hasError = false;
//   bool hasTimerStopped = false;
//   String passcode = '';
//   SignupRepository _signupRepository = new SignupRepository();
//   String _loginUserEmail = '';
//   TextEditingController controller = TextEditingController();
//   int _timerSecs = 300;
//   int pinLength = 6;
//   String thisText = "";

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void afterFirstLayout(BuildContext context) {
//     // Calling the same function "after layout" to resolve the issue.
//     if (_isConfrimationPending) {
//       // _onAlertotp(context);
//       _showOtpPopUp(context);
//     } else if (_isBSPDialogShow) {
//       _showDialogForBusiness();
//     } else {
//       print('user is regular');
//     }
//   }


//   void _showDialogForBusiness() async {
//     await Future.delayed(Duration(milliseconds: 50));
//     showDialog(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return TudoConditionDialogWidget(
//           labelbutton1: Text("No"),
//           labelbutton2: Text("Yes"),
//           title: Text("Are You Running a Business?"),
//           subText:
//               "TUDO.App aims at Businesses bridging gaps between Business Service Providers and Consumers collaborate on unique technology platform. If you own a business, we strongly recommend, provide your business information to grow your customer base and expand your business services. Any questions? Call us @1-800-888-TUDO",
//           onpressYes: () {
//             NavigationHelper.navigatetoBspsignupcreen(context);
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new WillPopScope(
//       onWillPop: () =>
//           SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
//       child: StoreConnector<AppState, CMRDashboardViewModel>(
//         converter: (Store<AppState> store) =>
//             CMRDashboardViewModel.fromStore(store),
//         onInit: (Store<AppState> store) {
//           print('I will be called when this components loads');
//           if (store.state.auth.loginUser != null) {
//             print(store.state.auth.loginUser.user.statusId);
//             String confirmationStatus =
//                 store.state.auth.loginUser.user.statusId;
//             _loginUserEmail = store.state.auth.loginUser.user.email;
//             print(
//                 'store.state.auth.loginUser.user = ${store.state.auth.loginUser.user.toJson()}');
//             print('user email');
//             print(_loginUserEmail);
//             int signInCount =
//                 (store.state.auth.loginUser.user.signInCount == null)
//                     ? 0
//                     : store.state.auth.loginUser.user.signInCount;
//             if (confirmationStatus == 'confirmation_pending') {
//               _isConfrimationPending = true;
//             }
//             print(signInCount);
//             signInCount = 0;
//             if (signInCount == 0) {
//               _isBSPDialogShow = true;
//             }
//           } else {
//             // _isConfrimationPending = true;
//             _isBSPDialogShow = true;
//           }
//           return store.state.auth.loginUser;
//         },
//         builder: (BuildContext context, CMRDashboardViewModel cmrDashboardVm) =>
//             content(context, cmrDashboardVm),
//       ),
//     );
//   }
// }

// class CMRDashboardViewModel {
//   final String error;
//   final LoginUser loginUser;
//   CMRDashboardViewModel({
//     this.error,
//     this.loginUser,
//   });

//   static CMRDashboardViewModel fromStore(Store<AppState> store) {
//     return CMRDashboardViewModel(
//       error: store.state.auth.error,
//       loginUser: store.state.auth.loginUser == null
//           ? null
//           : store.state.auth.loginUser,
//     );
//   }
// }
