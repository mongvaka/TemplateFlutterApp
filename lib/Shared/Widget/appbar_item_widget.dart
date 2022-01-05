import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:provider/src/provider.dart';

class AppbarItem extends StatelessWidget with PreferredSizeWidget {
  final List<IconButton> actions;
  final String title;

  AppbarItem({this.actions, this.title});
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.watch<Appsetting>().appColor,
      title: Text(title.tr()),
      centerTitle: true,
      leading: BackButton(),
      actions: actions,
    );
  }
}
