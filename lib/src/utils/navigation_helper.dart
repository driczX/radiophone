import 'package:flutter/material.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_page.dart';
import 'package:tudo/src/modules/cmr_dashboard/cmr_main_screen.dart';
import 'package:tudo/src/modules/forgot_password/forgotpassword_screen.dart';

import 'package:tudo/src/modules/language/language_screen.dart';
import 'package:tudo/src/modules/login/login_screen.dart';

import 'package:tudo/src/modules/signup/signup_screen.dart';

class NavigationHelper {
  static void navigatetologinscreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  static void navigatetoForgotpassword(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
  }

  static void navigatetoMainscreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  static void navigatetoSignupscreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  //=====================================================  Sign up Routing Start  ====================================================

  static void navigatetoBack(BuildContext context) {
    Navigator.pop(context, false);
  }

  static void navigatetoBspsignupcreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BspSignupPage()));
  }

  // static void navigatetoBsplicensedsignupterms(BuildContext context) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => BspLicensedSignupTermsPage()));
  // }

  // static void navigatetoBsplicensedsignup(BuildContext context) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => BspLicensedSignupPage()));
  // }

  // static void navigatetoBusinessprofile(BuildContext context) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => BusinessProfilePage()));
  // }

  // static void navigatetobusinessdetail(BuildContext context) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => BusinessDetailsPage()));
  // }

  static void navigatetolanguagescreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LanguageScreen()));
  }
}
