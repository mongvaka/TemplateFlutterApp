import 'package:flutter/material.dart';

class LoginModel {
  String user_name;
  String user_password;
  TextEditingController user_name_controler = new TextEditingController();
  TextEditingController user_password_controler = new TextEditingController();
  LoginModel({this.user_name, this.user_password});

  factory LoginModel.fromJson(Map<String, dynamic> json,
      {String user_username, String user_password}) {
    return LoginModel(
      user_name: json['user_username'],
      user_password: json['user_password'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_name': user_name,
      'user_password': user_password,
    };
  }

  Map<String, dynamic> getFromControllerToJson() {
    user_name = user_name_controler.text;
    user_password = user_password_controler.text;
    return {
      'user_name': user_name,
      'user_password': user_password,
    };
  }
}
