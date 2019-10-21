class Validators {
  static String validateName(String value, String type) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "$type is Required";
    } else if (!regExp.hasMatch(value)) {
      return "$type must be a-z and A-Z";
    }
    return null;
  }

  static String validateRequired(String value, String type) {
    if (value.length == 0) {
      return "$type is Required";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^\(?([0-9]{3})\)?[-.●]?([0-9]{3})[-.●]?([0-9]{4,5})$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Phone number is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Phone number is not valid (Minimum 10 digits)";
    }
    return null;
  }

  //For Email Verification we using RegEx.
  static String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.length <= 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    String pattern =
        r'^.*(?=.{8,})((?=.*[!@#$%^&*()\-_=+{};:,<.>]){1})(?=.*\d)((?=.*[a-z]){1})((?=.*[A-Z]){1}).*$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Password is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Minimum 8 characters password required with a combination of \n uppercase and lowercase letter and number are required.";
    } else {
      return null;
    }
  }

  String validatepass(String value) {
    if (value.isEmpty) {
      return 'Please enter Password';
    }
    if (value.length < 9) {
      return 'Must be more than 8 charater';
    } else {
      return null;
    }
  }

  String validateBusinessMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateestablishedyear(String value) {
    var date = new DateTime.now();
    int currentYear = date.year;
    int userinputValue = 0;

    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    // int numValue = int.parse(value);
    if (!regExp.hasMatch(value)) {
      return "Year must be number only";
    } else if (value is String && value.length == 0) {
      return "Established Year is Required";
    } else {
      userinputValue = int.parse(value);
    }

    if (userinputValue < 1850 || userinputValue > currentYear) {
      return "Year must be between 1850 and $currentYear";
    }
    return null;
  }

  String validateLicenseno(String value) {
    if (value.length == 0) {
      return "License No is Required";
    }
    return null;
  }

  String validatenumberofemployee(String value) {
    String patttern = r'(^[1-9]\d*(\.\d+)?$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Number of employee is Required";
    } else if (value.length > 4) {
      return "Number of employee is not more than 9999";
    } else if (!regExp.hasMatch(value)) {
      return "Number of employee must be digits";
    }
    return null;
  }

  String validatedate(String value) {
    String patttern = r'([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Date is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter valid date";
    }
    return null;
  }

  String validateLicenseissuingauthority(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "License Issuing Authority is Required";
    } else if (!regExp.hasMatch(value)) {
      return "License Issuing Authority must be a-z and A-Z";
    }
    return null;
  }
}
