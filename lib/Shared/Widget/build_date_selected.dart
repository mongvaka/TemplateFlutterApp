import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum_constans.dart';
import 'package:ice_fac_mobile/Shared/Function/datetime_function.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_condition.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:provider/src/provider.dart';

import 'cs_calendar.dart';

class BuildDateRangeSelected extends StatefulWidget {
  final String columnName;

  BuildDateRangeSelected({this.columnName});

  @override
  _BuildDateRangeSelectedState createState() => _BuildDateRangeSelectedState();
}

class _BuildDateRangeSelectedState extends State<BuildDateRangeSelected> {
  String startDate = null;
  String endDate = null;
  SearchCondition searchCondition;
  @override
  Widget build(BuildContext context) {
    return CsCalendar(
      isDateRang: true,
      hintText: 'SELECT_DATE',
      onConfirm: (DateTime dateTime, DateTimeRange dateTimeRange) {
        startDate = ConvertDateTime.convertDateToString(dateTimeRange.start);
        endDate = ConvertDateTime.convertDateToString(dateTimeRange.end);
        setSearchCondition();
        context.read<Appsetting>().addCondition(searchCondition);
      },
    );
  }

  void setSearchCondition() {
    searchCondition = new SearchCondition(
        columnName: widget.columnName,
        values: [startDate, endDate],
        conditionType: ConditionType.DATE_RANGE);
  }
}
