import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum_constans.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:provider/src/provider.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class Input extends StatefulWidget {
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

  Input({
    Key key,
    this.controller,
    this.hintText,
    this.helpText,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.enabled,
    this.readOnly,
    this.borderColor,
    this.mandatory,
    this.mandatoryText,
    this.onChange,
  }) : super(key: key);

  @override
  _InputState createState() => _InputState(
      // controller,
      // hintText,
      // helpText,
      // prefixIcon,
      // suffixIcon,
      // inputType,
      // enabled,
      // readOnly,
      // borderColor,
      // mandatory,
      // mandatoryText,
      // onChange,
      );
}

class _InputState extends State<Input> {
  // final TextEditingController controller;
  // final String hintText;
  // final String helpText;
  // final IconData prefixIcon;
  // final IconData suffixIcon;
  // final int inputType;
  // final bool enabled;
  // final bool readOnly;
  // final Color borderColor;
  // final bool mandatory;
  // final String mandatoryText;
  // final Function onChange;
  // bool _isobscure = true;

  // _InputState(
  //   this.controller,
  //   this.hintText,
  //   this.helpText,
  //   this.prefixIcon,
  //   this.suffixIcon,
  //   this.inputType,
  //   this.enabled,
  //   this.readOnly,
  //   this.borderColor,
  //   this.mandatory,
  //   this.mandatoryText,
  //   this.onChange,
  // );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: context.watch<Appsetting>().fieldHeight,
      child: TextFormField(
        onChanged: (String text) {
          if (widget.onChange != null) {
            widget.onChange(text);
          }
        },
        controller: widget.controller,
        obscureText: widget.inputType == TextFieldType.PASSWORD
            ? widget._isobscure
            : false,
        readOnly: null == widget.readOnly ? false : true,
        keyboardType: widget.inputType == TextFieldType.TEXT
            ? TextInputType.multiline
            : widget.inputType == TextFieldType.PASSWORD
                ? TextInputType.text
                : widget.inputType == TextFieldType.EMAIL
                    ? TextInputType.emailAddress
                    : widget.inputType == TextFieldType.NUMBER_8
                        ? TextInputType.number
                        : widget.inputType == TextFieldType.NUMBER_8_2
                            ? TextInputType.numberWithOptions(decimal: true)
                            : widget.inputType == TextFieldType.PHONE
                                ? TextInputType.phone
                                : null,
        textInputAction: widget.inputType == TextFieldType.NUMBER_8
            ? TextInputAction.done
            : widget.inputType == TextFieldType.NUMBER_8_2
                ? TextInputAction.done
                : widget.inputType == TextFieldType.PHONE
                    ? TextInputAction.done
                    : TextInputAction.done,
        maxLength: widget.inputType == TextFieldType.TEXT ? 500 : null,
        inputFormatters: widget.inputType == TextFieldType.NUMBER_8_2
            ? [
                ThousandsFormatter(allowFraction: true),
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9,.]+')),
                LengthLimitingTextInputFormatter(11)
              ]
            : widget.inputType == TextFieldType.NUMBER_8
                ? [
                    ThousandsFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9,]+')),
                    LengthLimitingTextInputFormatter(8)
                  ]
                : widget.inputType == TextFieldType.PHONE
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
                  color: null == widget.borderColor
                      ? context.watch<Appsetting>().appColor
                      : widget.borderColor,
                  width: 1)),
          labelText: null == widget.hintText ? '' : widget.hintText.tr(),
          helperText: null == widget.helpText ? '' : widget.helpText.tr(),
          prefixIcon:
              null == widget.prefixIcon ? null : Icon(widget.prefixIcon),
          suffixIcon: null == widget.suffixIcon
              ? null
              : widget.inputType == TextFieldType.PASSWORD
                  ? IconButton(
                      icon: Icon(widget.suffixIcon),
                      onPressed: () {
                        setState(() {
                          widget._isobscure = !widget._isobscure;
                        });
                      },
                    )
                  : Icon(widget.suffixIcon),
        ),
        validator: (String value) {
          if (widget.mandatory && (value == null || value.isEmpty)) {
            return null == widget.mandatoryText
                ? 'REQUIRED_FIELD'.tr()
                : widget.mandatoryText.tr();
          }
          if (widget.inputType == TextFieldType.TEXT && (value.length > 500)) {
            return 'Please enter a message no more than 500 characters.';
          }
          if (widget.inputType == TextFieldType.PASSWORD &&
              (value.length < 8)) {
            return 'Please enter a password greater than 8 characters.';
          }
          if (widget.inputType == TextFieldType.EMAIL &&
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
