import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ice_fac_mobile/Page/Bank/bank_list_page.dart';
import 'package:ice_fac_mobile/Page/Car/car_page.dart';
import 'package:ice_fac_mobile/Page/Login/login_service.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_button.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_text_feild.dart';
import 'package:ice_fac_mobile/ViewModel/login_view_model.dart';
import 'package:ice_fac_mobile/constants.dart';
import 'package:ice_fac_mobile/home_page.dart';

class LoginPage extends StatelessWidget {
  // static String rounteLogin = '/loginpage';
  get kLabelColor => null;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    LoginModel model = new LoginModel();
    LoginService service = new LoginService();
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(children: <Widget>[
            const SizedBox(height: 80),
            Text(
              "FIRST_TEXT".tr(),
              style: TextStyle(
                  fontSize: 36,
                  color: kLabelColor,
                  fontWeight: FontWeight.bold),
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    CsTextFeild(
                      controller: model.user_name_controler,
                      hintText: 'USER_NAME',
                      mandatory: true,
                      suffixIcon: Icons.add,
                    ),
                    CsTextFeild(
                      controller: model.user_password_controler,
                      hintText: "PASSWORD",
                      mandatory: true,
                    ),
                    CsButton(
                      text: "LOGIN",
                      onPress: () async {
                        if (formKey.currentState.validate()) {
                          try {
                            bool islogin = await service.login(model);
                            if (islogin) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            }
                          } catch (error) {
                            print('Error : $error');
                          }
                        } else {
                          print('notValidae');
                        }
                      },
                    )
                  ],
                )),
          ]),
        ),
      ),
    ));
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool remember = false;
  final user_name = TextEditingController();
  final user_password = TextEditingController();
  final List<String> errors = [];
  LoginService login_serveice = LoginService();

  Future getLogin() async {
    if (_formKey.currentState.validate()) {
      try {
        LoginModel model =
            new LoginModel(user_password: 'admin', user_name: 'admin');
        bool islogin = await login_serveice.login(model);
        if (islogin) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BankListPage()),
          );
        }
      } catch (error) {
        print('Error : $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 100),
          usernameFormField(),
          const SizedBox(height: 30),
          passwordFormField(),
          const SizedBox(height: 30),
          Row(
            children: [
              Checkbox(
                  value: remember,
                  onChanged: (value) {
                    setState(() {
                      remember = value;
                    });
                  }),
              Text(
                "Remember me",
                style: TextStyle(color: kSecondaryContentColor),
              ),
              Spacer(),
              Text(
                "Forgo Password",
                style: TextStyle(decoration: TextDecoration.underline),
              )
            ],
          ),
          formError(errors: errors),
          const SizedBox(height: 30),
          Container(
            width: size.width * 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  color: kPrimarkColor,
                  onPressed: () {
                    context.setLocale(Locale('en'));
                    getLogin();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          const SizedBox(height: 50),
          Text(
            "If you dont have an account \n please contact the personnel department",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kSecondaryContentColor,
            ),
          )
        ],
      ),
    );
  }

// Input Username
  TextFormField usernameFormField() {
    return TextFormField(
      // onSaved: (newValue) => username = this.username,
      controller: user_name,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kUsernameNullError)) {
          setState(() {
            errors.remove(kUsernameNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kUsernameNullError)) {
          setState(() {
            errors.add(kUsernameNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Please enter your username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
          child: SvgPicture.asset("assets/icons/User.svg"),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kLabelColor),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kLabelColor),
          gapPadding: 10,
        ),
      ),
    );
  }
// End Input Username

// Input Password
  TextFormField passwordFormField() {
    return TextFormField(
      obscureText: true,
      // onSaved: (newValue) => password = this.password,
      controller: user_password,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
        }
        // else if (value.length < 8 && !errors.contains(kShortPassError)) {
        //   setState(() {
        //     errors.add(kShortPassError);
        //   });
        // }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Please enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
          child: SvgPicture.asset("assets/icons/Lock.svg"),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kLabelColor),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kLabelColor),
          gapPadding: 10,
        ),
      ),
    );
  }
}
// End Input Password

// FormError
class formError extends StatelessWidget {
  const formError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }
}

Row formErrorText({String error}) {
  return Row(
    children: [
      SvgPicture.asset(
        "assets/icons/Error.svg",
        height: 20,
        width: 20,
      ),
      SizedBox(
        width: 10,
      ),
      Text(error)
    ],
  );
}
// End FormError
