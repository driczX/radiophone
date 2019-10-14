import 'package:flutter/material.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_page.dart';
import 'package:tudo/src/modules/cmr_dashboard/cmr_main_screen.dart';




class NavigationHelper {
 


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

 
}
