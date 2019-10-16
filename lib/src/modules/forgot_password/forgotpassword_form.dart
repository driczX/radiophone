import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:redux/redux.dart';
import 'package:tudo/src/modules/signup/signup_repository.dart';
import 'package:tudo/src/redux/actions/forgotpassword_actions.dart';
import 'package:tudo/src/redux/models/app_state.dart';
import 'package:tudo/src/shared/helpers/ensure_visible.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/validator.dart';
import 'package:tudo/src/widgets/fullscreenloader.dart';
import 'package:tudo/src/widgets/timer.dart';
import 'package:tudo/src/widgets/tudo_custom_widget/TudoErrorDialog.dart';
import 'package:tudo/src/widgets/tudo_text_widget/TudoPasswordWidget.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => new _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _newPassController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  final _emailFocusNode = new FocusNode();
  SignupRepository _signupRepository = new SignupRepository();
  int _timerSecs = 300;
  String _emailStr;
  String _newpasswordStr;
  var onTapRecognizer;
  TextEditingController controller = TextEditingController();
  int pinLength = 6;
  String thisText = "";

  PinCodeTextField pinCodeTextFieldWidget;
  bool hasError = false;
  String passcode = "";
  bool hasTimerStopped = false;
  bool _isEnabled = true;
  bool _passwordfiled = false;
  bool _isLoading = false;

  _resendCode() async {
    print('need to resend the code');
    setState(() {
      hasTimerStopped = true;
    });
    print('resending to the email ${_email.text}');
    await _signupRepository.resendToken(_email.text, 'forgot_password');
  }

  void _showErrorDialog(String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => ShowErrorDialog(
              title: Text('An Error Occurred!'),
              content: Text(message),
            ));
  }

  void _showOtpPopUp(BuildContext context) async {
    print('************Show OTP POPUP**************');
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter OTP'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2.4,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'We have Texted and/or Emailed OTP (One Time Pin) to your registered cell phone and/ or email account. Please check and enter OTP below to activate your TUDO account.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: CountDownTimer(
                          secondsRemaining: _timerSecs,
                          whenTimeExpires: () {
                            setState(() {
                              hasTimerStopped = true;
                            });
                          },
                          countDownTimerStyle: TextStyle(
                              fontSize: 25,
                              color: colorStyles["primary"],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          pinBoxWidth: MediaQuery.of(context).size.width / 20,
                          autofocus: false,
                          controller: controller,
                          highlight: true,
                          highlightColor: Colors.blue,
                          defaultBorderColor: Colors.black,
                          hasTextBorderColor: Colors.green,
                          maxLength: pinLength,
                          hasError: hasError,
                          onTextChanged: (text) {
                            setState(() {
                              hasError = false;
                            });
                          },
                          // onDone: (text) {
                          //   print("DONE $text");
                          // },
                          onDone: (String value) async {
                            setState(() {
                              passcode = value;
                              print(passcode);
                            });
                            if (passcode != '' && passcode.length == 6) {
                              Map<String, dynamic> otpVerification = await this
                                  ._signupRepository
                                  .activateUser(_email.text, passcode);
                              print(otpVerification);
                              if (otpVerification['error'] != null) {
                                setState(() {
                                  hasError = true;
                                });
                              } else {
                                print('User verfied successfully');
                                Navigator.pop(context);
                                setState(() {
                                  _isEnabled = !_isEnabled;
                                  _passwordfiled = true;
                                });
                              }
                            }
                          },
                          pinCodeTextFieldLayoutType:
                              PinCodeTextFieldLayoutType.NORMAL,
                          wrapAlignment: WrapAlignment.start,
                          pinBoxDecoration: ProvidedPinBoxDecoration
                              .underlinedPinBoxDecoration,
                          pinTextStyle: TextStyle(fontSize: 30.0),
                          pinTextAnimatedSwitcherTransition:
                              ProvidedPinBoxTextAnimation.scalingTransition,
                          pinTextAnimatedSwitcherDuration:
                              Duration(milliseconds: 300),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          hasError
                              ? "*Please fill up all the cells with valid code and press VERIFY again"
                              : "",
                          style: TextStyle(
                              color: Colors.red.shade300, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Didn't receive the code? ",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15),
                            children: [
                              TextSpan(
                                  text: "RESEND",
                                  style: TextStyle(
                                    color: colorStyles["primary"],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => _resendCode())
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
                            onPressed: () {
                              setState(() {
                                this.thisText = controller.text;
                              });
                            },
                            child: Center(
                              child: Text(
                                "VERIFY".toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: colorStyles["primary"],
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
      },
    );
  }

  Widget _buildRoundedRectButton(
      String title, List<Color> gradient, bool isEndIconVisible) {
    return Builder(builder: (BuildContext mContext) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Stack(
          alignment: Alignment(1.0, 0.0),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(mContext).size.width / 1.7,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.only(top: 16, bottom: 16),
            ),
            Visibility(
              visible: isEndIconVisible,
              child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ImageIcon(
                    AssetImage("assets/ic_forward.png"),
                    size: 30,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildLogo() {
    return new Image(
      image: new AssetImage("assets/logo.png"),
      height: 150,
      width: 150,
    );
  }

  Widget _buildUserNameField() {
    return EnsureVisibleWhenFocused(
      focusNode: _emailFocusNode,
      child: TextFormField(
        controller: _email,
        focusNode: _emailFocusNode,
        enabled: _isEnabled,
        decoration: new InputDecoration(
          prefixIcon: Icon(
            Icons.email,
          ),
          labelText: 'Email',
        ),
        // onSaved: (String value) {
        //   _emailStr = value.trim();
        // },
        validator: (val) => Validators.validateEmail(val.trim()),
        // validator: (val) =>
        //     val.isEmpty ? 'Your registered email id is required' : null,
      ),
    );
  }

  Widget _buildNewpassword() {
    return TudoPasswordWidget(
        hintText: "Enter your Password",
        labelText: "New Password",
        prefixIcon: Icon(Icons.vpn_key),
        controller: _newPassController,
        onSaved: (String value) {
          _newpasswordStr = value.trim();
        });
  }

  Widget _buildForgotPasswordButton(
      BuildContext context, ForgotPasswordViewModel forgotpasswordVm) {
    return GestureDetector(
      child: _buildRoundedRectButton(
          _passwordfiled ? "Update Password" : "Forgot Password",
          signUpGradients,
          false),
      onTap: () async {
        if (!formKey.currentState.validate()) {
          // Invalid!
          return;
        }
        formKey.currentState.save();
        print("Forgot Passowrd");
        try {
          setState(() {
            _isLoading = true;
          });
          print('_email.text');
          print(_email.text);
          Map<String, dynamic> forgotResponse = await _signupRepository
              .resendToken(_email.text, 'forgot_password');
          _showOtpPopUp(context);
          setState(() {
            _isLoading = false;
          });
          // }
        } catch (error) {
          setState(() {
            _isLoading = false;
          });
          var errorMessage = 'No Such a user exist in our system';
          _showErrorDialog(errorMessage);
        }
      },
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return FlatButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Icon(Icons.arrow_back_ios), Text("Back to Login")],
      ),
      onPressed: () => Navigator.pop(context, false),
    );
  }

  Widget content(context, forgotpasswordVm) {
    return Stack(
      children: <Widget>[
        Form(
          key: formKey,
          child: new Container(
            margin: EdgeInsets.fromLTRB(30, 100, 30, 0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLogo(),
                _buildUserNameField(),
                SizedBox(
                  height: 10,
                ),
                _passwordfiled ? _buildNewpassword() : SizedBox(),
                SizedBox(
                  height: 20.0,
                ),
                _buildForgotPasswordButton(context, forgotpasswordVm),
                SizedBox(
                  height: 20,
                ),
                _buildBackButton(context),
              ],
            ),
          ),
        ),
        _isLoading ? FullScreenLoader() : SizedBox(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ForgotPasswordViewModel>(
        converter: (Store<AppState> store) =>
            ForgotPasswordViewModel.fromState(store),
        builder:
            (BuildContext context, ForgotPasswordViewModel forgotPasswordVm) {
          return content(context, forgotPasswordVm);
        });
  }
}

class ForgotPasswordViewModel {
  final bool isLoading;
  final Function(BuildContext context, String username) forgotPwd;

  ForgotPasswordViewModel({this.isLoading, this.forgotPwd});

  static ForgotPasswordViewModel fromState(Store<AppState> store) {
    return ForgotPasswordViewModel(
      isLoading: store.state.forgotpassword.isLoading,
      forgotPwd: (context, username) {
        store.dispatch(forgotpassword(context, username));
      },
    );
  }
}

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

const List<Color> signUpGradients = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];
