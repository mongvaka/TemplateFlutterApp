import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum_constans.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_condition.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:provider/src/provider.dart';

class BuildBoolSelected extends StatefulWidget {
  final TextEditingController controller;
  bool activeFalse = false;
  bool activeTrue = false;
  bool activeAll = false;
  bool isActive = false;
  final String columnName;

  BuildBoolSelected({this.controller, @required this.columnName});

  @override
  _BuildBoolSelectedState createState() => _BuildBoolSelectedState();
}

class _BuildBoolSelectedState extends State<BuildBoolSelected> {
  @override
  // TODO: implement context
  BuildContext get context => super.context;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int index = getConditionIndex(context);
    if (index == -1) {
      widget.activeFalse = false;
      widget.activeTrue = false;
      widget.isActive = false;
    } else {
      SearchCondition condition = context
          .read<Appsetting>()
          .searchParameterModel
          .searchCondition[index];
      print('valll : ${condition.value}');
      if (condition.value == 'true') {
        widget.activeTrue = true;
      } else {
        widget.activeFalse = true;
      }
      widget.activeAll = !condition.isActive;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: CheckboxListTile(
              title: Text('ALL'),
              value: widget.activeAll,
              onChanged: (value) {
                widget.activeAll = value;
                widget.activeTrue = value;
                widget.activeFalse = value;
                SearchCondition searchCondition = new SearchCondition(
                    columnName: widget.columnName,
                    value: widget.activeTrue.toString(),
                    values: [widget.activeTrue.toString()],
                    isActive: !widget.activeAll,
                    conditionType: ConditionType.BOOL);
                context.read<Appsetting>().addCondition(searchCondition);
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: CheckboxListTile(
              title: Text('TRUE'),
              value: widget.activeTrue,
              onChanged: (value) {
                widget.activeTrue = value;
                widget.activeFalse = !value;
                widget.activeAll = false;
                SearchCondition searchCondition = new SearchCondition(
                    columnName: widget.columnName,
                    value: widget.activeTrue.toString(),
                    values: [widget.activeTrue.toString()],
                    isActive: !widget.activeAll,
                    conditionType: ConditionType.BOOL);
                context.read<Appsetting>().addCondition(searchCondition);
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: CheckboxListTile(
              title: Text('FALSE'),
              value: widget.activeFalse,
              onChanged: (value) {
                widget.activeTrue = !value;
                widget.activeFalse = value;
                widget.activeAll = false;
                SearchCondition searchCondition = new SearchCondition(
                    columnName: widget.columnName,
                    value: widget.activeTrue.toString(),
                    values: [widget.activeTrue.toString()],
                    isActive: !widget.activeAll,
                    conditionType: ConditionType.BOOL);
                context.read<Appsetting>().addCondition(searchCondition);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  // bool getValueSelected(BuildContext context) {
  //   bool sortColumnIssAccess = false;
  //   List<String> sortList = context.read<Appsetting>().searchParameterModel.sortColumns;
  //   for(var i = 0; i< sortList.length;i++){
  //     sortColumnIssAccess = true;
  //   }
  //   return sortColumnIssAccess;
  // }
  int getConditionIndex(BuildContext context) {
    int index = -1;
    List<SearchCondition> searchList =
        context.read<Appsetting>().searchParameterModel.searchCondition;
    for (var i = 0; i < searchList.length; i++) {
      if (searchList[i].columnName == widget.columnName) {
        index = i;
      }
    }
    return index;
  }
}
