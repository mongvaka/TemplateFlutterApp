import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ice_fac_mobile/Shared/Base/base_service.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_parameter_model.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/selected_item.dart';
import 'package:provider/provider.dart';

import 'build_item_selected.dart';

class BuildDropDownSelected extends StatefulWidget {
  final String dropdownUrl;
  final SearchParameterModel searchParameterModel;
  List<SelectedItem> selectList;
  BuildDropDownSelected({this.dropdownUrl, this.searchParameterModel});
  @override
  _BuildDropDownSelectedState createState() => _BuildDropDownSelectedState();
}

class _BuildDropDownSelectedState extends State<BuildDropDownSelected> {
  Future<List<SelectedItem>> datalist;
  @override
  void initState() {
    super.initState();
    datalist = getDropdownlist();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      future: datalist,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return DropdownSearch(
              mode: Mode.MENU,
              showSearchBox: true,
              showFavoriteItems: true,
              items: snapshot.data,
              itemAsString: (SelectedItem u) => u.label);
        } else {
          return CircularProgressIndicator();
        }
      },
    ));
  }

  Future<List<SelectedItem>> getDropdownlist() async {
    BaseService baseService = new BaseService();

    Response res = await baseService.getDropdown(
        widget.dropdownUrl, widget.searchParameterModel);
    List<dynamic> body = jsonDecode(res.body);
    return body.map((dynamic item) => SelectedItem.fromJson(item)).toList();
  }
}
