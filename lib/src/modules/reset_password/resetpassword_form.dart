import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tudo/src/utils/app_constants_value.dart';
import 'package:tudo/src/utils/validator.dart';

class ResetPasswordForm extends StatefulWidget {
  @override
  _ResetPasswordState createState() => new _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordForm> {
  final formKey = new GlobalKey<FormState>();

  bool rememberMe = false;

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

  final _passwordFocusNode = new FocusNode();
  bool _obscureText = true;
  final TextEditingController _newpass = new TextEditingController();
  String newpassword;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final _confirmpasswordFocusNode = new FocusNode();
  bool _confirmobscureText = true;
  final TextEditingController _confirmpass = new TextEditingController();
  String confirmpassword;

  void _confirmtoggle() {
    setState(() {
      _confirmobscureText = !_confirmobscureText;
    });
  }

  Widget _buildnewpassword() {
    return TextFormField(
      validator: Validators().validatePassword,
      obscureText: _obscureText,
      controller: _newpass,
      focusNode: _passwordFocusNode,
      decoration: new InputDecoration(
        filled: false,
        hintText: 'Enter your password',
        prefixIcon: Icon(
          Icons.vpn_key,
        ),
        suffixIcon: GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: _toggle,
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            semanticLabel: _obscureText
                ? AppConstantsValue.appConst['login']['show_password']
                    ['translation']
                : AppConstantsValue.appConst['login']['hide_password']
                    ['translation'],
          ),
        ),
        labelText: AppConstantsValue.appConst['reset']['newpass']
            ['translation'],
      ),
      onSaved: (String value) {
        newpassword = value.trim();
      },
    );
  }

  Widget _buildconfirmpassword() {
    return TextFormField(
      validator: Validators().validatePassword,
      obscureText: _confirmobscureText,
      controller: _confirmpass,
      focusNode: _confirmpasswordFocusNode,
      decoration: new InputDecoration(
        filled: false,
        hintText: 'Enter your password',
        prefixIcon: Icon(
          Icons.vpn_key,
        ),
        suffixIcon: GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: _confirmtoggle,
          child: Icon(
            _confirmobscureText ? Icons.visibility : Icons.visibility_off,
            semanticLabel: _confirmobscureText
                ? AppConstantsValue.appConst['login']['show_password']
                    ['translation']
                : AppConstantsValue.appConst['login']['hide_password']
                    ['translation'],
          ),
        ),
        labelText: AppConstantsValue.appConst['reset']['confirmpass']
            ['translation'],
      ),
      onSaved: (String value) {
        confirmpassword = value.trim();
      },
    );
  }

  Widget _buildResetPasswordButton(
    BuildContext context,
  ) {
    return GestureDetector(
      child: _buildRoundedRectButton("Reset Password", signUpGradients, false),
      onTap: () {},
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: new Container(
        margin: EdgeInsets.fromLTRB(30, 100, 30, 0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLogo(),
            SizedBox(
              height: 20.0,
            ),
            _buildnewpassword(),
            SizedBox(
              height: 20.0,
            ),
            _buildconfirmpassword(),
            SizedBox(
              height: 20,
            ),
            _buildResetPasswordButton(context),
            SizedBox(
              height: 20,
            ),
            _buildBackButton(context),
          ],
        ),
      ),
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
