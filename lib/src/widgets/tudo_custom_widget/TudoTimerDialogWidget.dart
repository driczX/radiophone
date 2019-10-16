import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tudo/src/modules/signup/signup_repository.dart';
import 'package:tudo/src/styles/colors.dart';

class TudoDialogWidget extends StatefulWidget {
  const TudoDialogWidget({
    this.onPressed,
    this.title,
    this.height,
    this.width,
    this.alignment,
    this.padding,
    this.subText,
    this.hasTimerStopped,
    this.secondsremaining,
    this.timerfontsize,
    this.timercolor,
    this.timerfontWeight,
    this.passcode,
    this.ondone,
    this.onErrorcheck,
    this.hasError,
    this.buttontext,
    this.color,
    this.fontweight,
    this.fontsize,
  });
  final GestureTapCallback onPressed;
  final Widget title;
  final double height;
  final double width;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final String subText;
  final bool hasTimerStopped;
  final int secondsremaining;
  final double timerfontsize;
  final Color timercolor;
  final FontWeight timerfontWeight;
  final String passcode;
  final ValueChanged<String> ondone;
  final ValueChanged<bool> onErrorcheck;
  final bool hasError;
  final String buttontext;
  final Color color;
  final FontWeight fontweight;
  final double fontsize;

  @override
  _TudoDialogWidgetState createState() => _TudoDialogWidgetState();
}

class _TudoDialogWidgetState extends State<TudoDialogWidget> {
  bool hasTimerStopped = false;
  String passcode;
  final changeNotifier = StreamController<Functions>.broadcast();
  SignupRepository _signupRepository = new SignupRepository();
  String _loginUserEmail = '';
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title ?? Text("Dialog Title"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Container(
              height: widget.height ?? MediaQuery.of(context).size.height / 2.4,
              width: widget.width ?? MediaQuery.of(context).size.height,
              alignment: widget.alignment,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: widget.padding ??
                        const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      widget.subText ?? 'Enter Your Subtext Here!!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: CountDownTimer(
                      secondsRemaining: widget.secondsremaining ?? 300,
                      whenTimeExpires: () {
                        setState(() {
                          hasTimerStopped = widget.hasTimerStopped;
                        });
                      },
                      countDownTimerStyle: TextStyle(
                        fontSize: widget.timerfontsize ?? 25,
                        color: widget.timercolor ?? Colors.amber,
                        fontWeight: widget.timerfontWeight ?? FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      length: 6, // must be greater than 0
                      obsecureText: false,
                      shape: PinCodeFieldShape.underline,
                      onDone: (String value) async {
                        setState(() {
                          passcode = value;
                          print(passcode);
                        });
                        if (passcode != '' && passcode.length == 6) {
                          Map<String, dynamic> otpVerification = await this
                              ._signupRepository
                              .activateUser(_loginUserEmail, passcode);
                          print(otpVerification);
                          if (otpVerification['errors'] != null) {
                            setState(() {
                              hasError = true;
                            });
                          } else {
                            print('User verfied successfully');
                            print(otpVerification['data']
                                ['registerConfirmation']);
                          }
                        }
                      },
                      // onDone: (String value) {
                      //   setState(() {
                      //     passcode = value;
                      //     print(value);
                      //   });
                      // },

                      textStyle: TextStyle(
                          fontWeight: FontWeight
                              .bold), //optinal, default is TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)
                      onErrorCheck: (bool value) {
                        setState(() {
                          hasError = value;
                        });
                      },
                      shouldTriggerFucntions:
                          changeNotifier.stream.asBroadcastStream(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasError
                          ? "*Please fill up all the cells and press VERIFY again"
                          : "",
                      style:
                          TextStyle(color: Colors.red.shade300, fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Didn't receive the code? ",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                        children: [
                          TextSpan(
                              text: " RESEND",
                              // recognizer: onTapRecognizer,
                              style: TextStyle(
                                  color: widget.color,
                                  fontWeight:
                                      widget.fontweight ?? FontWeight.bold,
                                  fontSize: widget.fontsize ?? 16))
                        ]),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 30),
                    child: ButtonTheme(
                      height: 50,
                      child: FlatButton(
                        onPressed: () async {
                          changeNotifier.add(Functions.submit);
                        },
                        child: Center(
                            child: Text(
                          widget.buttontext ?? "VERIFY".toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: widget.color ?? colorStyles["primary"],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({
    Key key,
    int secondsRemaining,
    this.countDownTimerStyle,
    this.whenTimeExpires,
    this.countDownFormatter,
  })  : secondsRemaining = secondsRemaining,
        super(key: key);

  final int secondsRemaining;
  final Function whenTimeExpires;
  final Function countDownFormatter;
  final TextStyle countDownTimerStyle;

  State createState() => new _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Duration duration;
  String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  String get timerDisplayString {
    Duration duration = _controller.duration * _controller.value;
    return widget.countDownFormatter != null
        ? widget.countDownFormatter(duration.inSeconds)
        : formatHHMMSS(duration.inSeconds);
    // In case user doesn't provide formatter use the default one
    // for that create a method which will be called formatHHMMSS or whatever you like
  }

  @override
  void initState() {
    super.initState();
    duration = new Duration(seconds: widget.secondsRemaining);
    _controller = new AnimationController(
      vsync: this,
      duration: duration,
    );
    _controller.reverse(from: widget.secondsRemaining.toDouble());
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.whenTimeExpires();
      }
    });
  }

  @override
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (_, Widget child) {
              return Text(
                timerDisplayString,
                style: widget.countDownTimerStyle,
              );
            }));
  }
}
