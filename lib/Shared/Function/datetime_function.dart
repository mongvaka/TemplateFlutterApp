import 'package:flutter/material.dart';

class ConvertDateTime {
  static convertDateToString(DateTime dateTime) {
    String day = dateTime.day.toString();
    String month = dateTime.month.toString();
    String year = dateTime.year.toString();
    return '${day}-${month}-${year}';
  }

  static convertTimeToString(TimeOfDay time) {
    print('time : ${time}');
    String hour = time.hour.toString();
    String minute = time.minute.toString();
    return '$hour : $minute';
  }
}
