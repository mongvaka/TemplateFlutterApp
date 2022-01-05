import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum_constans.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_condition.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/selected_item.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:provider/src/provider.dart';

class BuildSelectedItem extends StatefulWidget {
  final SelectedItem item;
  final String columnName;

  BuildSelectedItem({this.item, this.columnName});

  @override
  _BuildSelectedItemState createState() => _BuildSelectedItemState();
}

class _BuildSelectedItemState extends State<BuildSelectedItem> {
  SearchCondition searchCondition = new SearchCondition();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: ActionChip(
        padding: EdgeInsets.all(2),
        avatar: widget.item.isActive
            ? Icon(
                Icons.check,
                color: Colors.blue,
              )
            : SizedBox(),
        labelPadding: EdgeInsets.only(left: 4, right: 4),
        shape: StadiumBorder(
            side: BorderSide(
                color: widget.item.isActive ? Colors.blue : Colors.grey)),
        label: Text(widget.item.label,
            style: TextStyle(
                color: widget.item.isActive ? Colors.blue : Colors.grey)),
        labelStyle: TextStyle(color: Colors.grey),
        backgroundColor: widget.item.isActive ? Colors.white : Colors.white,
        onPressed: () {
          widget.item.isActive = !widget.item.isActive;
          setSearchCondition();
          context.read<Appsetting>().addCondition(searchCondition);
          setState(() {});
        },
      ),
    );
  }

  void setSearchCondition() {
    print('valueOriginal : ${widget.item.value}');
    searchCondition = new SearchCondition(
        columnName: widget.columnName,
        value: widget.item.value,
        isActive: widget.item.isActive,
        values: [widget.item.value],
        conditionType: ConditionType.LIST);
  }
}
