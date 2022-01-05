import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ice_fac_mobile/Shared/Function/datetime_function.dart';

class CsTime extends StatefulWidget {
  final Function onTimeChange;
  final DateTime startDate;
  final DateTime endDate;
  final bool selectTime;
  final TextEditingController controller;
  final Icons icon;
  final LocaleType localeType;

  final bool enabled;
  final bool readOnly;
  final Color borderColor;
  final bool mandatory;
  final String mandatoryText;
  final String hintText;
  final String helpText;
  final Function onChange;
  final Function onConfirm;

  CsTime(
      {this.onTimeChange,
      this.startDate,
      this.endDate,
      this.selectTime,
      this.controller,
      this.icon,
      this.localeType,
      this.enabled,
      this.readOnly,
      this.borderColor,
      this.mandatory,
      this.mandatoryText,
      this.hintText,
      this.helpText,
      this.onChange,
      this.onConfirm});

  @override
  _CsTimeState createState() => _CsTimeState();
}

class _CsTimeState extends State<CsTime> {
  TimeOfDay time;
  TimeOfDay picked;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // time = TimeOfDay.now();
  }

  Future<Null> selectTime(BuildContext context, TimeOfDay initTime) async {
    picked = await showTimePicker(
      context: context,
      initialTime: initTime,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (picked != null) {
      setState(() {
        time = picked;
      });
      print('ttt : ${widget.onTimeChange}');
      widget.onTimeChange(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextButton(
        onPressed: () {
          selectTime(context, TimeOfDay.now());
        },
        child: Row(children: [
          Expanded(
              flex: 8,
              child: Text(
                time == null
                    ? 'PLEASE_SELECT'
                    : ConvertDateTime.convertTimeToString(time),
                style: TextStyle(color: Colors.grey),
              )),
          Expanded(flex: 2, child: Icon(Icons.alarm))
        ]),
      ),
    );
  }
}
