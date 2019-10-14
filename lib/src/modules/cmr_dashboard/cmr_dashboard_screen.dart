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


// import 'package:tudo/src/redux/models/app_state.dart';
// import 'package:tudo/src/redux/models/login_user.dart';
// import 'package:tudo/src/styles/colors.dart';
// import 'package:tudo/src/widgets/tudo_custom_widget/TudoTimerDialogWidget.dart';

// class DashboardTab extends StatefulWidget {
//   @override
//   _DashboardTabState createState() => _DashboardTabState();
// }

// class _DashboardTabState extends State<DashboardTab>
//     with AfterLayoutMixin<DashboardTab> {
//   bool _isBSPDialogShow = false;
//   bool _isConfrimationPending = false;
//   bool hasError = false;
//   bool hasTimerStopped = false;
//   String passcode = '';
  
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

//   _resendCode() async {
//     print('need to resend the code');
//     setState(() {
//       hasTimerStopped = true;
//     });
//     await _signupRepository.resendToken(
//         _loginUserEmail, 'registration_activation');
//   }

//   void _showOtpPopUp(BuildContext context) async {
//     print('************Show OTP POPUP**************');
//     showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Enter OTP'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Container(
//                   height: MediaQuery.of(context).size.height / 2.4,
//                   width: MediaQuery.of(context).size.width,
//                   alignment: Alignment.center,
//                   child: ListView(
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: Text(
//                           'We have Texted and/or Emailed OTP (One Time Pin) to your registered cell phone and/ or email account. Please check and enter OTP below to activate your TUDO account.',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       Center(
//                         child: CountDownTimer(
//                           secondsRemaining: _timerSecs,
//                           whenTimeExpires: () {
//                             setState(() {
//                               hasTimerStopped = true;
//                             });
//                           },
//                           countDownTimerStyle: TextStyle(
//                               fontSize: 25,
//                               color: colorStyles["primary"],
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 30),
//                         child: PinCodeTextField(
//                           pinBoxWidth: MediaQuery.of(context).size.width / 20,
//                           autofocus: false,
//                           controller: controller,
//                           highlight: true,
//                           highlightColor: Colors.blue,
//                           defaultBorderColor: Colors.black,
//                           hasTextBorderColor: Colors.green,
//                           maxLength: pinLength,
//                           hasError: hasError,
//                           onTextChanged: (text) {
//                             setState(() {
//                               hasError = false;
//                             });
//                           },
//                           // onDone: (text) {
//                           //   print("DONE $text");
//                           // },
//                           onDone: (String value) async {
//                             setState(() {
//                               passcode = value;
//                               print(passcode);
//                             });
//                             if (passcode != '' && passcode.length == 6) {
//                               Map<String, dynamic> otpVerification = await this
//                                   ._signupRepository
//                                   .activateUser(_loginUserEmail, passcode);
//                               print(otpVerification);
//                               if (otpVerification['error'] != null) {
//                                 setState(() {
//                                   hasError = true;
//                                 });
//                               } else {
//                                 print('User verfied successfully');
//                                 print(otpVerification['data']
//                                     ['registerConfirmation']);
//                               }
//                             }
//                           },
//                           pinCodeTextFieldLayoutType:
//                               PinCodeTextFieldLayoutType.NORMAL,
//                           wrapAlignment: WrapAlignment.start,
//                           pinBoxDecoration: ProvidedPinBoxDecoration
//                               .underlinedPinBoxDecoration,
//                           pinTextStyle: TextStyle(fontSize: 30.0),
//                           pinTextAnimatedSwitcherTransition:
//                               ProvidedPinBoxTextAnimation.scalingTransition,
//                           pinTextAnimatedSwitcherDuration:
//                               Duration(milliseconds: 300),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Text(
//                           hasError
//                               ? "*Please fill up all the cells with valid code and press VERIFY again"
//                               : "",
//                           style: TextStyle(
//                               color: Colors.red.shade300, fontSize: 12),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       RichText(
//                         textAlign: TextAlign.center,
//                         text: TextSpan(
//                             text: "Didn't receive the code? ",
//                             style:
//                                 TextStyle(color: Colors.black54, fontSize: 15),
//                             children: [
//                               TextSpan(
//                                   text: "RESEND",
//                                   style: TextStyle(
//                                     color: colorStyles["primary"],
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = () => _resendCode())
//                             ]),
//                       ),
//                       SizedBox(
//                         height: 7,
//                       ),
//                       Container(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 16.0, horizontal: 30),
//                         child: ButtonTheme(
//                           height: 50,
//                           child: FlatButton(
//                             onPressed: () async {
//                               if (_isBSPDialogShow) {
//                                 Navigator.of(context).pop();
//                                 _showDialogForBusiness();
//                               }
//                             },
//                             child: Center(
//                               child: Text(
//                                 "VERIFY".toUpperCase(),
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                           color: colorStyles["primary"],
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('Close'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
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
//               "Congratulations!! Your TUDO Consumer account created successfully. \n\nTUDO app aims at Businesses bridging gaps between Business Service Providers and Consumers collaborate on the unique technology platform.",
//           subText2:
//               "If you own a business, we strongly recommend your click 'Yes', provide your business information to grow your customer base and expand your business services.",
//           subText3: "Any questions? Reach us @1-800-888-TUDO",
//           onpressYes: () {
//             NavigationHelper.navigatetoBspsignupcreen(context);
//           },
//         );
//       },
//     );
//   }

//   Widget content(context, cmrDashboardVm) {
//     return Container(
//       color: Colors.amber,
//       // backgroundColor: Colors.amber,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Container(
//             color: Colors.amber,
//             // margin: EdgeInsets.only(top: 10),
//             height: MediaQuery.of(context).size.height / 1.35,
//             child: Column(
//               children: <Widget>[
//                 Expanded(
//                     child: GridView.count(
//                   crossAxisCount: 2,
//                   padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
//                   // mainAxisSpacing: ,

//                   mainAxisSpacing: 10.0,
//                   // crossAxisSpacing: 5.0,
//                   children: List.generate(8, (index) {
//                     switch (index) {
//                       case 0:
//                         return Container(
//                           child: Stack(
//                             alignment: Alignment.topCenter,
//                             children: <Widget>[
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Container(
//                                     width: 120,
//                                     height: 120,
//                                     child: Icon(
//                                       Icons.done_all,
//                                       color: Colors.black,
//                                     ),
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(20))),
//                                   ),
//                                   Text(
//                                     'Deals',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               Positioned(
//                                 top: MediaQuery.of(context).size.width / 150,
//                                 right: MediaQuery.of(context).size.width / 30,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   height: 35,
//                                   width: 35,
//                                   decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         "12",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // margin: EdgeInsets.only(top: 30, left: 40),
//                         );

//                         break;
//                       case 1:
//                         return Container(
//                           child: Stack(
//                             alignment: Alignment.topCenter,
//                             children: <Widget>[
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   GestureDetector(
//                                     onTap: () {
//                                       print("Hello");
//                                     },
//                                     child: Container(
//                                       width: 120,
//                                       height: 120,
//                                       child: Icon(
//                                         Icons.image,
//                                         color: Colors.white,
//                                       ),
//                                       decoration: BoxDecoration(
//                                           color: Colors.black,
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(20))),
//                                     ),
//                                   ),
//                                   Text(
//                                     'EvenTer',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Positioned(
//                                 top: MediaQuery.of(context).size.width / 150,
//                                 right: MediaQuery.of(context).size.width / 30,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   height: 35,
//                                   width: 35,
//                                   decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         "55",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // margin: EdgeInsets.only(top: 30, left: 40),
//                         );
//                         break;
//                       case 2:
//                         return Container(
//                           child: Stack(
//                             alignment: Alignment.topCenter,
//                             children: <Widget>[
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   GestureDetector(
//                                     onTap: () {},
//                                     child: Container(
//                                       width: 120,
//                                       height: 120,
//                                       child: Icon(
//                                         Icons.music_note,
//                                         color: Colors.white,
//                                       ),
//                                       decoration: BoxDecoration(
//                                           color: Colors.black,
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(20))),
//                                     ),
//                                   ),
//                                   Text(
//                                     'Hanging',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               Positioned(
//                                 top: MediaQuery.of(context).size.width / 150,
//                                 right: MediaQuery.of(context).size.width / 30,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   height: 35,
//                                   width: 35,
//                                   decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         "34",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // margin: EdgeInsets.only(top: 30, left: 40),
//                         );

//                         break;
//                       case 3:
//                         return Container(
//                           child: Stack(
//                             alignment: Alignment.topCenter,
//                             children: <Widget>[
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Container(
//                                     width: 120,
//                                     height: 120,
//                                     child: Icon(
//                                       Icons.cloud,
//                                       color: Colors.black,
//                                     ),
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(20))),
//                                   ),
//                                   Text(
//                                     'MyNet',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               Positioned(
//                                 top: MediaQuery.of(context).size.width / 150,
//                                 right: MediaQuery.of(context).size.width / 30,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   height: 35,
//                                   width: 35,
//                                   decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         "55",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // margin: EdgeInsets.only(top: 30, left: 40),
//                         );

//                         break;
//                       case 4:
//                         return Container(
//                           child: Stack(
//                             alignment: Alignment.topCenter,
//                             children: <Widget>[
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Container(
//                                     width: 120,
//                                     height: 120,
//                                     child: Icon(Icons.description,
//                                         color: Colors.black),
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(20))),
//                                   ),
//                                   Text(
//                                     'NTer',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               Positioned(
//                                 top: MediaQuery.of(context).size.width / 150,
//                                 right: MediaQuery.of(context).size.width / 30,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   height: 35,
//                                   width: 35,
//                                   decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         "90",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // margin: EdgeInsets.only(top: 30, left: 40),
//                         );

//                         break;
//                       case 5:
//                         return Container(
//                           child: Stack(
//                             alignment: Alignment.topCenter,
//                             children: <Widget>[
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Container(
//                                     width: 120,
//                                     height: 120,
//                                     child: Icon(
//                                       Icons.play_arrow,
//                                       color: Colors.white,
//                                     ),
//                                     decoration: BoxDecoration(
//                                         color: Colors.black,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(20))),
//                                   ),
//                                   Text(
//                                     'Payments',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               Positioned(
//                                 top: MediaQuery.of(context).size.width / 150,
//                                 right: MediaQuery.of(context).size.width / 30,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   height: 35,
//                                   width: 35,
//                                   decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         "1",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // margin: EdgeInsets.only(top: 30, left: 40),
//                         );

//                         break;
//                       case 6:
//                         return Container(
//                           child: Stack(
//                             alignment: Alignment.topCenter,
//                             children: <Widget>[
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Container(
//                                     width: 120,
//                                     height: 120,
//                                     child: Icon(
//                                       Icons.games,
//                                       color: Colors.white,
//                                     ),
//                                     decoration: BoxDecoration(
//                                         color: Colors.black,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(20))),
//                                   ),
//                                   Text(
//                                     'Reports',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               Positioned(
//                                 top: MediaQuery.of(context).size.width / 150,
//                                 right: MediaQuery.of(context).size.width / 30,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   height: 35,
//                                   width: 35,
//                                   decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         "43",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // margin: EdgeInsets.only(top: 30, left: 40),
//                         );

//                         break;
//                       case 7:
//                         return Container(
//                           child: Stack(
//                             alignment: Alignment.topCenter,
//                             children: <Widget>[
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Container(
//                                     width: 120,
//                                     height: 120,
//                                     child: Icon(
//                                       Icons.cached,
//                                       color: Colors.black,
//                                     ),
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(20))),
//                                   ),
//                                   Text(
//                                     'Schedule',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               Positioned(
//                                 top: MediaQuery.of(context).size.width / 150,
//                                 right: MediaQuery.of(context).size.width / 30,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   height: 35,
//                                   width: 35,
//                                   decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         "23",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // margin: EdgeInsets.only(top: 30, left: 40),
//                         );

//                         break;
//                       case 8:
//                         return Container(
//                           child: Stack(
//                             alignment: Alignment.topCenter,
//                             children: <Widget>[
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Container(
//                                     width: 120,
//                                     height: 120,
//                                     child: Icon(
//                                       Icons.delete,
//                                       size: 40,
//                                       color: Colors.white,
//                                     ),
//                                     decoration: BoxDecoration(
//                                         color: Color(0xfffcb127),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(25))),
//                                   ),
//                                   Text(
//                                     'Bin',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               Positioned(
//                                 top: MediaQuery.of(context).size.width / 150,
//                                 right: MediaQuery.of(context).size.width / 30,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   height: 35,
//                                   width: 35,
//                                   decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         "11",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // margin: EdgeInsets.only(top: 30, left: 40),
//                         );

//                         break;
//                     }
//                   }),
//                 ))
//               ],
//             ),
//           ),
//         ],
//       ),
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
