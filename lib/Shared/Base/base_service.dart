import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:ice_fac_mobile/Shared/Constants/base_url.dart';
import 'package:ice_fac_mobile/Shared/LocalStorage/local_storage.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/error_message.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_parameter_model.dart';
import 'package:http/http.dart' as http;

class BaseService {
  Future<Response> getList(
      String url, SearchParameterModel searchParameter) async {
    String authorization = getAuthorization();
    String api_url = BaseUrl.BASE_URL + url;
    Map model = searchParameter.toJson();
    Response res = await http.post(Uri.parse(api_url),
        body: jsonEncode(model),
        headers: {'authorization': authorization},
        encoding: Encoding.getByName("utf-8"));
    print('req.body : ${res.body}');

    if (res.statusCode == 200) {
      return res;
    } else {
      print("Can't get posts");
    }
  }

  Future<Response> getDropdown(
      String url, SearchParameterModel searchParameter) async {
    try {
      print('searchParameter.toJson(): ${searchParameter.toJson()}');
      String authorization = getAuthorization();
      String api_url = BaseUrl.BASE_URL + url;
      Map model = searchParameter.toJson();
      Response res = await http.post(Uri.parse(api_url),
          body: jsonEncode(model),
          headers: {'authorization': authorization},
          encoding: Encoding.getByName("utf-8"));
      if (res.statusCode == 200) {
        return res;
      } else {
        print("Can't get posts");
      }
    } catch (e) {
      print('thisErrorMessage: $e');
    }
  }

  Future<Response> getListCar(
      String url, SearchParameterModel searchParameter) async {
    String authorization = getAuthorization();
    String api_url = BaseUrl.BASE_URL + url;
    print('$api_url');
    Response res = await http.post(Uri.parse(api_url),
        body: {},
        headers: {'authorization': authorization},
        encoding: Encoding.getByName("utf-8"));
    if (res.statusCode == 200) {
      return res;
    } else {
      print("Can't get posts !!!!!");
    }
  }

  Future<Response> getLogin(String url, dynamic data) async {
    String api_url = BaseUrl.BASE_URL + url;
    print('$api_url');
    dynamic res = await http.post(Uri.parse(api_url),
        body: data, encoding: Encoding.getByName("utf-8"));
    if (res.statusCode == 200) {
      return res;
    } else {
      print("Can't get posts");
    }
  }

  Future<Response> getView(String url, String id) async {
    String api_url = BaseUrl.BASE_URL + url;
    String authorization = getAuthorization();
    Response res = await http.post(Uri.parse(api_url),
        body: {'primaryKey': id},
        headers: {'authorization': authorization},
        encoding: Encoding.getByName("utf-8"));
    if (res.statusCode == 200) {
      return res;
    } else {
      print("Can't get posts");
    }
  }

  // Future<Response> post(String id) async {}
  Future<Response> create(String url, dynamic model) async {
    print(model);
    String api_url = BaseUrl.BASE_URL + url;
    String authorization = getAuthorization();
    Response res = await http.post(Uri.parse(api_url),
        body: model,
        headers: {'authorization': authorization},
        encoding: Encoding.getByName("utf-8"));
    if (res.statusCode == 200) {
      return res;
    } else {
      print("Can't get posts");
    }
  }

  Future<Response> edit(String url, dynamic model) async {
    String api_url = BaseUrl.BASE_URL + url;
    String authorization = getAuthorization();
    Response res = await http.post(Uri.parse(api_url),
        body: model,
        headers: {'authorization': authorization},
        encoding: Encoding.getByName("utf-8"));
    if (res.statusCode == 200) {
      return res;
    } else {
      print("Can't get posts");
    }
  }

  Future<Response> delete(String url, String id) async {
    String api_url = BaseUrl.BASE_URL + url;
    String authorization = getAuthorization();
    Response res = await http.post(Uri.parse(api_url),
        body: {'primaryKey': id},
        headers: {'authorization': authorization},
        encoding: Encoding.getByName("utf-8"));
    if (res.statusCode == 200) {
      return res;
    } else {
      print("Can't get posts");
    }
  }

  String getAuthorization() {
    LocalStorageCustom localStorageCustom = new LocalStorageCustom();
    String access_token = localStorageCustom.getAccess_token();
    String company_uuid = localStorageCustom.getCompany_uuid();
    String branch_uuid = localStorageCustom.getBranch_uuid();
    return '$access_token $company_uuid $branch_uuid';
  }

  Future<Response> post(String url, dynamic model) async {
    String api_url = BaseUrl.BASE_URL + url;

    Response res = await http.post(Uri.parse(api_url),
        body: model, encoding: Encoding.getByName("utf-8"));

    if (res.statusCode == 200) {
      return res;
    } else {
      dynamic body = jsonDecode(res.body);
      ErrorMessage errorMessage = ErrorMessage.fromJson(body);
      Fluttertoast.showToast(
          msg: errorMessage.code + errorMessage.errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
