import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum_constans.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_condition.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_text_feild.dart';

class TextFieldSelected extends StatefulWidget {
  final int inputType;
  final String columnName;
  final int conditionType;

  TextFieldSelected({this.inputType, this.columnName, this.conditionType});

  @override
  _TextFieldSelectedState createState() => _TextFieldSelectedState();
}

class _TextFieldSelectedState extends State<TextFieldSelected> {
  TextEditingController controller;
  SearchCondition searchCondition = new SearchCondition();
  String textSearch;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CsTextFeild(
      controller: controller,
      inputType: widget.inputType,
      onChange: (String text) {
        textSearch = text;
        setSearchCondition();
      },
    );
  }

  void setSearchCondition() {
    searchCondition = new SearchCondition(
        columnName: widget.columnName,
        value: textSearch,
        conditionType: widget.conditionType);
  }
}
