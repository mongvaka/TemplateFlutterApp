import 'dart:convert';

import 'package:http/http.dart';
import 'package:ice_fac_mobile/Shared/Base/base_service.dart';
import 'package:ice_fac_mobile/Shared/Constants/base_url.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_parameter_model.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/selected_item.dart';

class BaseDropdownService {
  getCarDropdownFunction(
      String baseModule, SearchParameterModel searchParameter) {
    return this.getCarDropdown(baseModule, searchParameter);
  }

  Future<List<SelectedItem>> getCarDropdown(
      String baseModule, SearchParameterModel searchParameter) async {
    try {
      BaseService baseService = new BaseService();
      String url = '/$baseModule/GetCarDropdown';
      Response res = await baseService.getDropdown(url, searchParameter);
      List<dynamic> body = jsonDecode(res.body);
      return body.map((dynamic item) => SelectedItem.fromJson(item)).toList();
    } catch (e) {
      print('thisE  $e');
    }
  }
}
