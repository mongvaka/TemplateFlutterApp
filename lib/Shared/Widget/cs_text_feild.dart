import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum_constans.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:provider/src/provider.dart';

class CsTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String helpText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final int inputType;
  final bool enabled;
  final bool readOnly;
  final Color borderColor;
  final bool mandatory;
  final String mandatoryText;
  final Function onChange;
  bool _isobscure = true;

  CsTextFeild(
      {this.controller,
      this.hintText,
      this.helpText,
      this.prefixIcon,
      this.suffixIcon,
      this.inputType,
      this.enabled,
      this.readOnly,
      this.borderColor,
      this.mandatory = false,
      this.mandatoryText,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: context.watch<Appsetting>().fieldHeight,
      child: TextFormField(
        onChanged: (String text) {
          if (onChange != null) {
            onChange(text);
          }
        },
        controller: controller,
        obscureText: inputType == TextFieldType.PASSWORD ? _isobscure : false,
        readOnly: null == readOnly ? false : true,
        keyboardType: inputType == TextFieldType.TEXT
            ? TextInputType.text
            : inputType == TextFieldType.PASSWORD
                ? TextInputType.text
                : inputType == TextFieldType.EMAIL
                    ? TextInputType.emailAddress
                    : inputType == TextFieldType.NUMBER_8
                        ? TextInputType.number
                        : inputType == TextFieldType.NUMBER_8_2
                            ? TextInputType.numberWithOptions(decimal: true)
                            : inputType == TextFieldType.PHONE
                                ? TextInputType.phone
                                : null,
        maxLength: inputType == TextFieldType.TEXT ? 500 : null,
        inputFormatters: inputType == TextFieldType.NUMBER_8_2
            ? [
                ThousandsFormatter(allowFraction: true),
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9,.]+')),
                LengthLimitingTextInputFormatter(11)
              ]
            : inputType == TextFieldType.NUMBER_8
                ? [
                    ThousandsFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9,]+')),
                    LengthLimitingTextInputFormatter(8)
                  ]
                : inputType == TextFieldType.PHONE
                    ? [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9+]+')),
                        LengthLimitingTextInputFormatter(10)
                      ]
                    : null,
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
          labelText: null == hintText ? '' : hintText.tr(),
          helperText: null == helpText ? '' : helpText.tr(),
          prefixIcon: null == prefixIcon ? null : Icon(prefixIcon),
          suffixIcon:
              null == suffixIcon ? null : IconButton(icon: Icon(suffixIcon)),
        ),
        validator: (String value) {
          if (mandatory && (value == null || value.isEmpty)) {
            return null == mandatoryText
                ? 'REQUIRED_FIELD'.tr()
                : mandatoryText.tr();
          }
          if (inputType == TextFieldType.TEXT && (value.length > 500)) {
            return 'Please enter a message no more than 500 characters.';
          }
          if (inputType == TextFieldType.PASSWORD && (value.length < 8)) {
            return 'Please enter a password greater than 8 characters.';
          }
          if (inputType == TextFieldType.EMAIL &&
              !value.contains(RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
            return 'Please fill in your email in the form : admin@kraois.com';
          }
          return null;
        },
        style: (TextStyle(fontSize: context.watch<Appsetting>().fontSize)),
      ),
    );
  }
}
