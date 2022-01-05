import 'package:flutter/material.dart';

class CsButton extends StatelessWidget {
  final Function onPress;
  final String text;
  final Color color;

  CsButton({this.onPress, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      margin: EdgeInsets.only(left: 10, top: 0, bottom: 0),
      child: OutlinedButton(
        onPressed: onPress,
        child: Text(text),
      ),
    );
  }
}
