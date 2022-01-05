import 'dart:convert';

import 'package:http/http.dart';
import 'package:ice_fac_mobile/Shared/Base/base_service.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_parameter_model.dart';
import 'package:ice_fac_mobile/ViewModel/car_list_view.dart';

class CarServeice {
  BaseService baseService = new BaseService();
  Future<List<CarListView>> getCarList(
      SearchParameterModel searchParameter) async {
    String url = '/car/getCarTableList';
    Response res = await baseService.getListCar(url, searchParameter);
    print('Res : $res');
    List<dynamic> body = jsonDecode(res.body);
    return body.map((dynamic item) => CarListView.fromJson(item)).toList();
  }
}
