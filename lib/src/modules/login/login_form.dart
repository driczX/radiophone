import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tudo/src/modules/login/login_repository.dart';
import 'package:tudo/src/redux/actions/auth_actions.dart';
import 'package:tudo/src/redux/models/app_state.dart';
import 'package:tudo/src/redux/models/login_user.dart';
import 'package:tudo/src/shared/helpers/ensure_visible.dart';
import 'package:tudo/src/utils/app_constants_value.dart';
import 'package:tudo/src/utils/navigation_helper.dart';
import 'package:tudo/src/utils/validator.dart';
import 'package:tudo/src/widgets/fullscreenloader.dart';
import 'package:tudo/src/widgets/tudo_button_widget/TudoLoginButtonWidget.dart';
import 'package:tudo/src/widgets/tudo_custom_widget/TudoErrorDialog.dart';
import 'package:tudo/src/widgets/tudo_custom_widget/TudoLogoWidget.dart';
import 'package:tudo/src/widgets/tudo_text_widget/TudoEmailWidget.dart';
import 'package:tudo/src/widgets/tudo_text_widget/TudoPasswordWidget.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = new GlobalKey<FormState>();
  final _emailFocusNode = new FocusNode();
  final _passwordFocusNode = new FocusNode();

  String _username;
  String _password;
  bool rememberMe = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
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

  Widget _buildUserNameField() {
    return EnsureVisibleWhenFocused(
      focusNode: _emailFocusNode,
      child: TudoEmailWidget(
        focusNode: _emailFocusNode,
        prefixIcon: Icon(Icons.email),
        labelText: AppConstantsValue.appConst['login']['email']['translation'],
        validator: (val) => Validators.validateEmail(val.trim()),
        onSaved: (val) => _username = val.trim(),
        // onChanged:(val) => _username = val.trim(),
      ),
    );
  }

  Widget _buildPasswordField() {
    return EnsureVisibleWhenFocused(
      focusNode: _passwordFocusNode,
      child: TudoPasswordWidget(
        focusNode: _passwordFocusNode,
        prefixIcon: Icon(Icons.vpn_key),
        hintText: AppConstantsValue.appConst['login']['password']
            ['translation'],
        labelText: AppConstantsValue.appConst['login']['password']
            ['translation'],
        validator: Validators().validatePassword,
        onSaved: (val) => _password = val.trim(),
      ),
    );
  }

  Widget _buildForgotPass() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Checkbox(
              value: rememberMe,
              onChanged: (bool value) {
                setState(() {
                  rememberMe = value;
                });
              },
            ),
            Text("Remember Me?"),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              child: GestureDetector(
                onTap: () {
                  NavigationHelper.navigatetoForgotpassword(context);
                },
                child: Text("Forgot Password?"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context, LoginViewModel loginVm) {
    return GestureDetector(
      child: TudoLoginButtonWidget.buildRoundedRectButton(
          "Log In", signInGradients, false),
      onTap: () async {
        if (!formKey.currentState.validate()) {
          // Invalid!
          return;
        }
        formKey.currentState.save();

        setState(() {
          _isLoading = true;
        });

        try {
          LoginRepository _loginRepository = LoginRepository();
          Map<String, dynamic> loginResponse =
              await _loginRepository.loginUser(_username, _password);
          if (loginResponse['error'] != null) {
            var errorMessage = 'Invalid email or password';
            _showErrorDialog(errorMessage);
          } else {
            LoginUser userModel = LoginUser(
              token: loginResponse['data']['loginUser']['token'],
              user: User.fromJson(
                loginResponse['data']['loginUser']['user'],
              ),
            );
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            if (rememberMe) {
              preferences.setString('user', loginUserToJson(userModel));
              preferences.setBool('rememberMe', true);
            }
            loginVm.loginMe(context, userModel);
          }
          setState(() {
            _isLoading = false;
          });
        } catch (error) {
          print('error');
          print(error);
          setState(() {
            _isLoading = false;
          });
          var errorMessage = 'Authentication failed';
          _showErrorDialog(errorMessage);
        }
      },
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return GestureDetector(
      child: TudoLoginButtonWidget.buildRoundedRectButton(
          "Sign Up", signUpGradients, false),
      onTap: () {
        NavigationHelper.navigatetoSignupscreen(context);
      },
    );
  }

  Widget content(context, loginVm) {
    return Stack(
      children: <Widget>[
        Form(
          key: formKey,
          child: Scrollbar(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: new Container(
                margin: EdgeInsets.fromLTRB(30, 100, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TudoLogoWidget(),
                    _buildUserNameField(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildPasswordField(),
                    _buildForgotPass(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildLoginButton(context, loginVm),
                    SizedBox(
                      height: 20,
                    ),
                    _buildSignupButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
        _isLoading ? FullScreenLoader() : SizedBox(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, LoginViewModel>(
      converter: (Store<AppState> store) => LoginViewModel.fromStore(store),
      builder: (BuildContext context, LoginViewModel loginVm) =>
          content(context, loginVm),
    );
  }
}

class LoginViewModel {
  final Function(BuildContext context, LoginUser loginUser) loginMe;
  LoginViewModel({
    this.loginMe,
  });

  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
      loginMe: (context, loginUser) {
        store.dispatch(
          login(context, loginUser),
        );
      },
    );
  }
}
