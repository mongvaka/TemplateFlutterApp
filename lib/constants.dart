import 'package:flutter/material.dart';

const kPrimarkColor = Color(0xFF2D88FF);
const kButtomColor = Color(0xFF81B5FB);
const kButtomClaseColor = Color(0xFFFFD2D2);
const kBodyColor = Color(0xFFffffff);
const kTextInputLoginColor = Color(0xFFe6e7e8);
const kTextInputColor = Color(0xFFdedfe0);
const kMandatoreColor = Color(0xFFC4C4C4);
const kLabelColor = Color(0xFF000000);
const kSecondaryContentColor = Color(0xFFB4B2B2);
const kAnimationDuration = Duration(microseconds: 200);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);

final headingStyle = TextStyle(
  // fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

final RegExp usernameValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kUsernameNullError = "Please Enter your Username";
const String kInvalidUsernameError = "Please Enter Valid Username";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

// final otpInputDecoration = InputDecoration(
//   contentPadding:
//       EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
//   border: outlineInputBorder(),
//   focusedBorder: outlineInputBorder(),
//   enabledBorder: outlineInputBorder(),
// );

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    // borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kLabelColor),
  );
}
