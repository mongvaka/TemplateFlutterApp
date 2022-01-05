import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:provider/src/provider.dart';

class ColorCell extends StatelessWidget {
  final Color color;

  ColorCell({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: 72,
        height: 72,
        decoration: BoxDecoration(color: color),
        child: context.watch<Appsetting>().appColor == color
            ? Icon(
                Icons.check_circle,
                color: Colors.white,
              )
            : SizedBox());
  }
}
