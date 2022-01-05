import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum_constans.dart';
import 'package:ice_fac_mobile/Shared/Function/datetime_function.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_condition.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_time.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:provider/src/provider.dart';

class BuildTimeRangeSelected extends StatefulWidget {
  final String columnName;

  BuildTimeRangeSelected({this.columnName});

  @override
  _BuildTimeRangeSelectedState createState() => _BuildTimeRangeSelectedState();
}

class _BuildTimeRangeSelectedState extends State<BuildTimeRangeSelected> {
  TimeOfDay startTime;
  TimeOfDay endTime;
  SearchCondition searchCondition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime = null;
    endTime = null;
    searchCondition = new SearchCondition();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: CsTime(
            onTimeChange: (TimeOfDay timeOfDay) {
              startTime = timeOfDay;
              setSearchCondition();
              context.read<Appsetting>().addCondition(searchCondition);
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: CsTime(
            onTimeChange: (TimeOfDay timeOfDay) {
              endTime = timeOfDay;
              setSearchCondition();
              context.read<Appsetting>().addCondition(searchCondition);
            },
          ),
        ),
      ],
    );
  }

  void setSearchCondition() {
    searchCondition = new SearchCondition(
        columnName: widget.columnName,
        values: [
          startTime == null
              ? 'null'
              : ConvertDateTime.convertTimeToString(startTime),
          endTime == null
              ? 'null'
              : ConvertDateTime.convertTimeToString(endTime)
        ],
        conditionType: ConditionType.TIME_RANGE);
  }
}
