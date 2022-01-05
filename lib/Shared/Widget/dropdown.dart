import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/selected_item.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:provider/src/provider.dart';

class DropDown extends StatefulWidget {
  TextEditingController controller;
  List<SelectedItem> options;
  // final SelectedItem options;
  final String lable;
  DropDown({
    Key key,
    this.options,
    this.controller,
    this.lable,
  }) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        height: context.watch<Appsetting>().fieldHeight,
        child: DropdownSearch<SelectedItem>(
          mode: Mode.MENU,
          showSearchBox: true,
          showFavoriteItems: true,
          items: widget.options,
          itemAsString: (SelectedItem u) => u.label,
          // ignore: deprecated_member_use
          label: widget.lable,
          onChanged: (SelectedItem value) {
            widget.controller.text = value.value;
          },
        ));
  }

  void onChange(SelectedItem model) {}
}
