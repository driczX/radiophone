import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:redux/redux.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tudo/src/modules/signup/model/countries.dart';
import 'package:tudo/src/modules/signup/signup_repository.dart';
import 'package:tudo/src/redux/actions/signup_actions.dart';
import 'package:tudo/src/redux/models/app_state.dart';
import 'package:tudo/src/redux/models/login_user.dart' as LUser;
import 'package:tudo/src/redux/models/signup_user.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/app_constants_value.dart';
import 'package:tudo/src/utils/navigation_helper.dart';
import 'package:tudo/src/utils/validator.dart';
import 'package:tudo/src/widgets/fullscreenloader.dart';
import 'package:tudo/src/widgets/loader.dart';
import 'package:tudo/src/widgets/timer.dart';
import 'package:tudo/src/widgets/tudo_button_widget/TudoPrimaryButtonWidget.dart';
import 'package:tudo/src/widgets/tudo_custom_widget/TudoErrorDialog.dart';
import 'package:tudo/src/widgets/tudo_selection_widget/TudoTermsandConditionWidget.dart';
import 'package:tudo/src/widgets/tudo_text_widget/TudoEmailWidget.dart';
import 'package:tudo/src/widgets/tudo_text_widget/TudoNumberWidget.dart';
import 'package:tudo/src/widgets/tudo_text_widget/TudoPasswordWidget.dart';
import 'package:tudo/src/widgets/tudo_text_widget/TudoTextWidget.dart';

// import 'package:pin_code_text_field/pin_code_text_field.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => new _SignupScreenState();
}

_launchURL() async {
  const url = 'https://flutter.io';
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
  //   throw 'Could not launch $url';
  // }
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = new GlobalKey<FormState>();
  bool _validate = false;
  List<Country> _countries = [];
  Person person = new Person();
  var mobilecontroller = new MaskedTextController(mask: '(000)-000-0000');
  String passcode = '';
  final _emailFocusNode = new FocusNode();
  final _passwordFocusNode = new FocusNode();
  final _fnameFocusNode = new FocusNode();
  final _lnameFocusNode = new FocusNode();

  final TextEditingController _email = new TextEditingController();
  final TextEditingController _add = new TextEditingController();
  final TextEditingController _fn = new TextEditingController();
  final TextEditingController _ln = new TextEditingController();
  final TextEditingController _pho = new TextEditingController();
  final TextEditingController _pass = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController controller = TextEditingController();
  static List<CountryModel> _dropdownItems = new List();
  String otpWaitTimeLabel = "";
  CountryModel _dropdownValue;
  TextEditingController otpcontroller = TextEditingController();
  String thisText = "";
  int pinLength = 6;
  bool hasError = false;
  bool showAlertBox = false;
  bool _isLoading = false;
  String errorMessage;
  DateTime target;
  bool hasTimerStopped = false;
  SignupRepository _signupRepository = new SignupRepository();

  int _timerSecs = 300;

  @override
  void initState() {
    super.initState();

    _signupRepository.getCountries().then((countries) {
      setState(() {
        _countries = countries.countries;
      });
    });
    getdeviceinfo();
    getLocationinfo();
    print(Platform.operatingSystem);
  }

  Future<dynamic> getdeviceinfo() async {
    SharedPreferences devicepref = await SharedPreferences.getInstance();
    String stringdevice = devicepref.getString('deviceinfo');
    print("DEVICE");
    print(stringdevice);
  }

  Future<dynamic> getLocationinfo() async {
    SharedPreferences locatpref = await SharedPreferences.getInstance();
    String stringlocationinfo = locatpref.getString('locationinfo');
    print("LOCATION");
    print(stringlocationinfo);
  }

  Widget _buildLogo() {
    return new Image(
      image: new AssetImage("assets/logo.png"),
      height: 120,
      width: 120,
    );
  }

  Widget _buildEmailField() {
    return TudoEmailWidget(
      controller: _email,
      focusNode: _emailFocusNode,
      prefixIcon: Icon(Icons.email),
      labelText: AppConstantsValue.appConst['signup']['email']['translation'],
      validator: (val) => Validators.validateEmail(val.trim()),
      onSaved: (String value) {
        print('person');
        print(person);
        setState(() {
          person.email = value.trim();
        });
      },
    );
  }

  Widget _buildTermsAndContionsCheck() {
    return TudoTermsandConditionWidget(
      text: "I have read and agree to TUDO",
      linktext: " Legal Terms and Condition",
      onTap: () => _launchURL(),
      errortext: "You must accept terms and conditions to continue",
    );
  }

  Widget _buildCountry(List<Country> countries) {
    if (countries.length > 0 && _dropdownItems.length != countries.length - 1) {
      print("countries list");
      print(countries[0].name);
      for (int i = 0; i < countries.length; i++) {
        if (countries[i].name.toLowerCase() != 'world') {
          _dropdownItems.add(
            CountryModel(
              id: countries[i].id,
              country: countries[i].name,
              countryCode: countries[i].isdCode,
            ),
          );
        }
      }
    }
    return FormBuilder(
      autovalidate: true,
      initialValue: {},
      child: FormBuilderCustomField(
        attribute: "Country",
        validators: [
          FormBuilderValidators.required(),
        ],
        formField: FormField(
          builder: (FormFieldState<dynamic> field) {
            return DropdownButtonHideUnderline(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new InputDecorator(
                    decoration: InputDecoration(
                      filled: false,
                      hintText: 'Choose Country',
                      prefixIcon: Icon(Icons.location_on),
                      labelText: _dropdownValue == null
                          ? 'Select your country'
                          : 'From',
                      errorText: field.errorText,
                    ),
                    isEmpty: _dropdownValue == null,
                    child: new DropdownButton<CountryModel>(
                      value: _dropdownValue,
                      isDense: true,
                      onChanged: (CountryModel newValue) {
                        print('value change');
                        print(newValue);
                        person.countryId = newValue.id;
                        person.country = newValue.country;
                        person.countryCode = newValue.countryCode;
                        setState(() {
                          _dropdownValue = newValue;
                          phoneController.text = _dropdownValue.countryCode;
                        });
                        field.didChange(newValue);
                      },
                      items: _dropdownItems.map(
                        (CountryModel value) {
                          return DropdownMenuItem<CountryModel>(
                            value: value,
                            child: Text(value.country),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPhonefiled() {
    return Row(
      children: <Widget>[
        new Expanded(
          child: new TudoTextWidget(
            controller: phoneController,
            enabled: false,
            prefixIcon: Icon(FontAwesomeIcons.globe),
            labelText: "code",
            hintText: "Country Code",
          ),
          flex: 2,
        ),
        new SizedBox(
          width: 10.0,
        ),
        new Expanded(
          child: new TudoNumberWidget(
              controller: mobilecontroller,
              validator: Validators().validateMobile,
              hintText: "Phone Number",
              labelText: "Phone Number",
              prefixIcon: Icon(Icons.phone),
              onSaved: (String value) {
                person.phoneNumber = value.trim();
              }),
          flex: 5,
        ),
      ],
    );
  }

  Widget _buildFnamefiled() {
    return TudoTextWidget(
      controller: _fn,
      focusNode: _fnameFocusNode,
      textCapitalization: TextCapitalization.sentences,
      hintText: 'Enter your First name',
      prefixIcon: Icon(
        Icons.account_circle,
      ),
      labelText: AppConstantsValue.appConst['signup']['firstname']
          ['translation'],
      // validator: Validators().validateName,
      validator: (val) => Validators.validateName(val, "First Name"),
      onSaved: (String value) {
        person.firstname = value.trim();
      },
    );
  }

  Widget _buildLnamefiled() {
    return TudoTextWidget(
      controller: _ln,
      focusNode: _lnameFocusNode,
      textCapitalization: TextCapitalization.sentences,
      hintText: 'Enter your Last name',
      prefixIcon: Icon(
        Icons.account_circle,
      ),
      labelText: AppConstantsValue.appConst['signup']['lastname']
          ['translation'],
      // validator: Validators().validateName,
      validator: (val) => Validators.validateName(val, "Last Name"),
      onSaved: (String value) {
        person.lastname = value.trim();
      },
    );
  }

  Widget _buildPasswordfiled() {
    return TudoPasswordWidget(
      validator: Validators().validatePassword,
      controller: _pass,
      focusNode: _passwordFocusNode,
      hintText: 'Enter your password',
      prefixIcon: Icon(
        Icons.vpn_key,
      ),
      labelText: AppConstantsValue.appConst['signup']['password']
          ['translation'],
      onSaved: (String value) {
        person.password = value.trim();
      },
    );
  }

  _resendCode() async {
    print('need to resend the code');
    setState(() {
      hasTimerStopped = false;
      _timerSecs = 300;
    });
    print('resending to the email ${_email.text}');
    await _signupRepository.resendToken(_email.text, 'registration_activation');
  }

  void _showOtpPopUp(BuildContext context, SignupViewModel signupVm) async {
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
                                print(otpVerification['data']
                                    ['registerConfirmation']);
                                LUser.LoginUser userModel = LUser.LoginUser(
                                  token: otpVerification['data']
                                      ['registerConfirmation']['token'],
                                  user: LUser.User.fromJson(
                                    otpVerification['data']
                                        ['registerConfirmation'],
                                  ),
                                );
                                signupVm.loginUser(context, userModel);
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
                            // onPressed: () async {
                            //   changeNotifier.add(Functions.submit);
                            // },
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

  void _showErrorDialog(String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => ShowErrorDialog(
              title: Text('An Error Occurred!'),
              content: Text(message),
            ));
  }

  Widget _buildSignupButton(BuildContext context, SignupViewModel signupVm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new TudoPrimaryButtonWidget(
          icon: Icon(Icons.close),
          label: Text('Clear'),
          textColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          onPressed: () {
            _formKey.currentState.reset();
            _email.text = "";
            _email.clear();
            _fn.clear();
            _ln.clear();
            _pho.clear();
            _add.clear();
            _pass.clear();
            mobilecontroller.clear();
          },
        ),
        new TudoPrimaryButtonWidget(
          icon: Icon(FontAwesomeIcons.arrowAltCircleRight),
          label: Text("TUDO Sign up"),
          color: colorStyles["primary"],
          textColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          onPressed: () async {
            if (!_formKey.currentState.validate()) {
              // Invalid!
              return;
            }
            _formKey.currentState.save();
            print("Signup User");
            try {
              setState(() {
                _isLoading = true;
              });
              Map<String, dynamic> signUpUserMap = {
                'email': person.email = _email.text.trim(),
                'password': person.password = _pass.text,
                'phoneNumber': person.phoneNumber = mobilecontroller.text,
                'firstName': person.firstname = _fn.text.trim(),
                'lastName': person.lastname = _ln.text.trim(),
                'countryId': person.countryId,
              };
              SignupRepository _signupRepository = SignupRepository();
              Map<String, dynamic> signupResponse =
                  await _signupRepository.signupUser(signUpUserMap);

              print(signupResponse);

              if (signupResponse['error'] != null) {
                var errorMessage = 'User Already Exists';
                setState(() {
                  _isLoading = false;
                });

                _showErrorDialog(errorMessage);
                // throw HttpException(loginResponse['error']);
              } else {
                setState(() {
                  _isLoading = false;
                });

                _showOtpPopUp(context, signupVm);
              }
            } catch (error) {
              setState(() {
                _isLoading = false;
              });
              var errorMessage = 'Signup failed';
              _showErrorDialog(errorMessage);
            }
          },
        )
      ],
    );
  }

  Widget content(context, signupVm, List<Country> countries) {
    final appbar = AppBar(
      title: Text("TUDO Sign Up"),
      // leading: Icon(Icons.arrow_back_ios),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          NavigationHelper.navigatetoBack(context);
        },
      ),
      centerTitle: true,
    );

    return new Scaffold(
      appBar: appbar,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: _formKey,
            autovalidate: _validate,
            child: Stack(
              children: <Widget>[
                // Background(),
                SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.down,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: new Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _buildLogo(),
                        _buildEmailField(),
                        _buildCountry(countries),
                        _buildPhonefiled(),
                        _buildFnamefiled(),
                        _buildLnamefiled(),
                        _buildPasswordfiled(),
                        _buildTermsAndContionsCheck(),
                        _buildSignupButton(context, signupVm),
                      ],
                    ),
                  ),
                ),
                _isLoading ? FullScreenLoader() : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, SignupViewModel>(
      converter: (Store<AppState> store) => SignupViewModel.fromState(store),
      builder: (BuildContext context, SignupViewModel signupVm) =>
          content(context, signupVm, _countries),
    );
  }
}

class SignupViewModel {
  final bool isLoading;
  final SignupUser signupUser;
  final String error;
  final Function(BuildContext context, Person person) signupMe;
  final Function(BuildContext context, LUser.LoginUser user) loginUser;
  SignupViewModel({
    this.isLoading,
    this.error,
    this.signupUser,
    this.signupMe,
    this.loginUser,
  });

  static SignupViewModel fromState(Store<AppState> store) {
    return SignupViewModel(
        isLoading: store.state.signup.isLoading,
        error: store.state.signup.error,
        signupUser: store.state.signup.signupUser,
        signupMe: (context, person) {
          store.dispatch(
            signup(context, person),
          );
        },
        loginUser: (context, user) {
          store.dispatch(
            loginUserFirstTime(context, user),
          );
        });
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

class Person {
  String email = '';
  String country = '';
  String countryId = '';
  String countryCode = '';
  String phoneNumber = '';
  String firstname = '';
  String lastname = '';
  String password = '';
  bool termsAndCondition = false;
}

class CountryModel {
  String country = '';
  String id = '';
  String countryCode = '';

  CountryModel({
    this.id,
    this.country,
    this.countryCode,
  });
}
