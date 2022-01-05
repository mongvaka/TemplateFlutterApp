import 'dart:convert';

import 'package:http/http.dart';
import 'package:ice_fac_mobile/Shared/Base/base_service.dart';
import 'package:ice_fac_mobile/Shared/Constants/base_url.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_parameter_model.dart';
import 'package:ice_fac_mobile/ViewModel/bank_item_view.dart';
import 'package:ice_fac_mobile/ViewModel/bank_list_view.dart';
import 'package:ice_fac_mobile/ViewModel/search_result.dart';

class BankService {
  final String _moduleName = '/Bank';
  BaseService _baseService = new BaseService();
  Future<SearchResult> getBankList(SearchParameterModel searchParameter) async {
    String url = '$_moduleName/getBankTableList';
    Response res = await _baseService.getList(url, searchParameter);
    dynamic searchResult = jsonDecode(res.body);
    print('searchResult : $searchResult');
    if (res.statusCode == 200) {
      return SearchResult.formJson(searchResult);
    } else {
      return null;
    }
  }

  Future<BankItemView> getBankItemById(String id) async {
    String url = '$_moduleName/getBankTableById';
    Response res = await _baseService.getView(url, id);
    dynamic body = jsonDecode(res.body);
    return BankItemView.fromJson(body);
  }

  Future<BankItemView> createBank(BankItemView model) async {
    String url = '$_moduleName/createBankTable';
    print('url: $url');
    Response res =
        await _baseService.create(url, model.getFromControllerToJson());
    print('res: $res');
    dynamic body = jsonDecode(res.body);
    print('body: $body');
    return BankItemView.fromJson(body);
  }

  Future<BankItemView> editBank(BankItemView model) async {
    String url = '$_moduleName/editBankTable';
    Response res =
        await _baseService.edit(url, model.getFromControllerToJson());
    dynamic body = jsonDecode(res.body);
    return BankItemView.fromJson(body);
  }

  Future<BankListView> deleteBank(String id) async {
    String url = '$_moduleName/deleteBankTable';
    Response res = await _baseService.delete(url, id);
    dynamic body = jsonDecode(res.body);
    return BankListView.fromJson(body);
  }

  Future<BankItemView> initialCreateData() async {
    return new BankItemView();
  }
}
