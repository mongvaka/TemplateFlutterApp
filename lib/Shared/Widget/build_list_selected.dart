import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ice_fac_mobile/Shared/Base/base_service.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_parameter_model.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/selected_item.dart';
import 'package:provider/provider.dart';

import 'build_item_selected.dart';

class BuildListSelected extends StatefulWidget {
  final String dropdownUrl;
  final SearchParameterModel searchParameterModel;
  List<SelectedItem> selectList;
  BuildListSelected({this.dropdownUrl, this.searchParameterModel});
  @override
  _BuildListSelectedState createState() => _BuildListSelectedState();
}

class _BuildListSelectedState extends State<BuildListSelected> {
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
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List<Widget>.generate(snapshot.data.length, (index) {
                  return BuildSelectedItem(item: snapshot.data[index]);
                })),
          );
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
