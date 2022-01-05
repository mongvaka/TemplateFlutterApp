import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:ice_fac_mobile/Shared/Base/base_service.dart';
import 'package:ice_fac_mobile/Shared/LocalStorage/local_storage.dart';
import 'package:ice_fac_mobile/ViewModel/local_storage_item_view.dart';
import 'package:ice_fac_mobile/ViewModel/login_view_model.dart';

class LoginService {
  Future<dynamic> login(LoginModel model) async {
    BaseService baseService = new BaseService();
    String url = '/auth/login';
    Response res = await baseService.post(url, model.getFromControllerToJson());
    if (res != null) {
      dynamic body = jsonDecode(res.body);
      LocalStorageCustom localStorageCustom = new LocalStorageCustom();
      await localStorageCustom
          .setDataLogin(LocalStorageItemView.fromJson(body));
      print(localStorageCustom.getAccess_token());
      Fluttertoast.showToast(
          msg: 'login success',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return true;
    } else {
      return false;
    }
  }
}
