import 'dart:io';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/selected_item.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:provider/src/provider.dart';

class CsDropdown extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String helpText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final bool enabled;
  final bool readOnly;
  final Color borderColor;
  final bool mandatory;
  final String mandatoryText;
  final Function onChange;
  final List<SelectedItem> options;
  CsDropdown(
      {this.controller,
      this.hintText,
      this.helpText,
      this.prefixIcon,
      this.suffixIcon,
      this.enabled,
      this.readOnly,
      this.borderColor,
      this.mandatory,
      this.mandatoryText,
      this.options,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.watch<Appsetting>().fieldHeight,
        child: TextFormField(
          onTap: () {
            showItemList(context);
          },
          controller: controller,
          readOnly: null == readOnly ? true : readOnly,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: context.watch<Appsetting>().appColor, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1)),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: null == borderColor
                        ? context.watch<Appsetting>().appColor
                        : borderColor,
                    width: 1)),
            hintText: null == hintText ? '' : hintText.tr(),
            helperText: null == helpText ? '' : helpText.tr(),
            suffixIcon: Icon(Icons.keyboard_arrow_down),
          ),
          validator: (value) {
            if (mandatory && (value == null || value.isEmpty)) {
              return null == mandatoryText
                  ? 'REQUIRED_FIELD'.tr()
                  : mandatoryText.tr();
            }
            return null;
          },
          style: (TextStyle(fontSize: context.watch<Appsetting>().fontSize)),
        ));
  }

  Future<dynamic> showItemList(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              child: Wrap(
                  children: options
                      .map((SelectedItem model) => ListTile(
                            title: Text(model.label),
                            onTap: () {
                              controller.text = model.value;
                              onChange(model);
                            },
                          ))
                      .toList()),
            ));
    // }
  }
}
