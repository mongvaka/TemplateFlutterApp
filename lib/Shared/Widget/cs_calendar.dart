import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:provider/src/provider.dart';
import '../../constants.dart';

class CsCalendar extends StatefulWidget {
  final TextEditingController controller;
  final DateTime startDate;
  final DateTime endDate;
  final bool selectTime;
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
  final bool isDateRang;
  CsCalendar(
      {this.startDate,
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
      this.isDateRang = false,
      this.onConfirm});

  @override
  _CsCalendarState createState() => _CsCalendarState();
}

class _CsCalendarState extends State<CsCalendar> {
  DateTime selectedDate = DateTime.now();
  DateTimeRange selectedDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: context.watch<Appsetting>().fieldHeight,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextButton(
        onPressed: () async {
          DateTime dateTime;
          DateTimeRange dateTimeRange;
          if (widget.isDateRang) {
            dateTimeRange = await showDateTimeRangeSelect();
          } else {
            dateTime = await showDateTimeSelect();
          }

          setState(() {
            widget.onConfirm(dateTime, dateTimeRange);
            selectedDate = dateTime;
            selectedDateRange = dateTimeRange;
            if (selectedDate != null) {
              // widget.controller.text =
              //     DateFormat('dd/MM/yyyy').format(selectedDate);
            }
            if (selectedDateRange != null) {
              // widget.controller.text =
              //     DateFormat('dd/MM/yyyy').format(selectedDateRange.start) +
              //         ' - ' +
              //         DateFormat('dd/MM/yyyy').format(selectedDateRange.end);
            }
          });
        },
        child: Row(children: [
          Expanded(
            flex: 5,
            child: Text(
              selectedDate != null
                  ? DateFormat('dd/MM/yyyy').format(selectedDate)
                  : selectedDateRange != null
                      ? DateFormat('dd/MM/yyyy')
                              .format(selectedDateRange.start) +
                          ' - ' +
                          DateFormat('dd/MM/yyyy').format(selectedDateRange.end)
                      : 'PLEASE_SELECT',
              style: TextStyle(color: kSecondaryContentColor),
            ),
          ),
          Expanded(flex: 1, child: Icon(Icons.calendar_today_rounded))
        ]),
      ),
    );
  }

  Future<DateTimeRange> showDateTimeRangeSelect() {
    return showDateRangePicker(
      context: context,
      initialDateRange:
          DateTimeRange(start: DateTime.now(), end: DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      locale: Locale('th', 'TH'),
    );
  }

  Future<DateTime> showDateTimeSelect() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      locale: Locale('th', 'TH'),
    );
  }
}
