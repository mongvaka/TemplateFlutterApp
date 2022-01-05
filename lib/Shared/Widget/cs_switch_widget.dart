import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:provider/src/provider.dart';

class CSSwitch extends StatefulWidget {
  bool isSwicth = false;
  final TextEditingController controller;
  CSSwitch({Key key, this.controller}) : super(key: key);

  @override
  _CSSwitchState createState() => _CSSwitchState();
}

class _CSSwitchState extends State<CSSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: context.watch<Appsetting>().fieldHeight,
      child: FlutterSwitch(
        width: 55.0,
        height: 25.0,
        valueFontSize: 12.0,
        toggleSize: 18.0,
        value: widget.isSwicth,
        borderRadius: 30.0,
        onToggle: (value) {
          setState(() {
            widget.isSwicth = value;
            widget.controller.text = value.toString();
          });
        },
      ),
    );
  }
}
