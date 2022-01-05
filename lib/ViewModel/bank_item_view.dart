import 'package:flutter/cupertino.dart';
import 'package:ice_fac_mobile/Shared/Base/base_item_model.dart';

class BankItemView {
  String bank_uuid;
  String bank_code;
  String bank_name;
  String bank_branch;
  String bank_number;
  String bank_number_2;
  String bank_phone;
  String bank_dropdown;
  String bank_date;
  // bool bank_status;
  String bank_status;
  String create_by;
  String update_by;
  String create_date;
  String update_date;

  TextEditingController bank_code_controler = new TextEditingController();
  TextEditingController bank_name_controler = new TextEditingController();
  TextEditingController bank_branch_controler = new TextEditingController();
  TextEditingController bank_number_controler = new TextEditingController();
  TextEditingController bank_number_2_controler = new TextEditingController();
  TextEditingController bank_phone_controler = new TextEditingController();
  TextEditingController bank_dropdown_controler = new TextEditingController();
  TextEditingController bank_date_controler = new TextEditingController();
  TextEditingController bank_status_controler = new TextEditingController();

  BankItemView(
      {this.bank_uuid,
      this.bank_code,
      this.bank_name,
      this.bank_branch,
      this.bank_number,
      this.bank_number_2,
      this.bank_phone,
      this.bank_dropdown,
      this.bank_date,
      this.bank_status,
      this.create_by,
      this.update_by,
      this.create_date,
      this.update_date});

  factory BankItemView.fromJson(Map<String, dynamic> json) {
    return BankItemView(
        bank_uuid: json['bank_uuid'],
        bank_code: json['bank_code'],
        bank_name: json['bank_name'],
        bank_branch: json['bank_branch'],
        bank_number: json['bank_number'],
        bank_number_2: json['bank_number_2'],
        bank_phone: json['bank_phone'],
        bank_dropdown: json['bank_dropdown'],
        bank_date: json['bank_date'],
        bank_status: json['bank_status'],
        create_by: json['create_by'],
        update_by: json['update_by'],
        create_date: json['create_date'].toString(),
        update_date: json['update_date'].toString());
  }
  Map<String, dynamic> getFromControllerToJson() {
    bank_code = bank_code_controler.text;
    bank_name = bank_name_controler.text;
    bank_branch = bank_branch_controler.text;
    bank_number = bank_number_controler.text;
    bank_number_2 = bank_number_2_controler.text;
    bank_phone = bank_phone_controler.text;
    bank_dropdown = bank_dropdown_controler.text;
    bank_date = bank_date_controler.text;
    bank_status = bank_status_controler.text;

    return {
      'bank_code': bank_code,
      'bank_name': bank_name,
      'bank_branch': bank_branch,
      'bank_number': bank_number,
      'bank_number_2': bank_number_2,
      'bank_phone': bank_phone,
      'bank_dropdown': bank_dropdown,
      'bank_date': bank_date,
      'bank_status': bank_status,
    };
  }

  void assignControllerToModel() {
    bank_code_controler.text = bank_code;
    bank_name_controler.text = bank_name;
    bank_branch_controler.text = bank_branch;
    bank_number_controler.text = bank_number;
    bank_number_2_controler.text = bank_number_2;
    bank_dropdown_controler.text = bank_dropdown;
    bank_date_controler.text = bank_date;
    bank_status_controler.text = bank_status;
  }
}
