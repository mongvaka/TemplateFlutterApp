import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CsAppBar extends PreferredSize {
  final Widget child;
  final double height;
  final Color color;
  CsAppBar({@required this.child, this.height, this.color});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: color ?? Colors.red,
      child: child,
      alignment: Alignment.center,
    );
  }
}
