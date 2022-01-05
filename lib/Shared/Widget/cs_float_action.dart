import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class CsFloatAction extends StatelessWidget {
  final Function onPressed;
  final String label;
  final Icon icon;
  final Color color;

  CsFloatAction({this.onPressed, this.label, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: null == label ? Text('SAVE'.tr()) : Text(label.tr()),
      icon: null == icon ? Icon(Icons.save) : icon,
      backgroundColor: null == color ? Colors.green : color,
    );
  }
}
