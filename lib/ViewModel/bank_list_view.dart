import 'package:ice_fac_mobile/ViewModel/bank_item_view.dart';

class BankListView {
  final String bank_uuid;
  final String bank_code;
  final String bank_name;
  final String bank_branch;

  BankListView(
      {this.bank_uuid, this.bank_code, this.bank_name, this.bank_branch});
  factory BankListView.fromJson(Map<dynamic, dynamic> json) {
    return BankListView(
      bank_uuid: json['bank_uuid'],
      bank_code: json['bank_code'],
      bank_name: json['bank_name'],
      bank_branch: json['bank_branch'],
    );
  }
  static List<BankListView> fromArray(List<dynamic> array) {
    return array.map((item) => BankListView.fromJson(item)).toList();
  }

  factory BankListView.formItem(BankItemView itemView) {
    return BankListView(
        bank_uuid: itemView.bank_uuid,
        bank_code: itemView.bank_code,
        bank_name: itemView.bank_name,
        bank_branch: itemView.bank_branch);
  }
}
