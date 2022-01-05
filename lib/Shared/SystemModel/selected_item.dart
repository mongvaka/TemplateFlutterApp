class SelectedItem {
  final String label;
  final String value;
  final dynamic rowData;
  bool isActive;

  SelectedItem({this.label, this.value, this.rowData, this.isActive});
  factory SelectedItem.fromJson(Map<dynamic, dynamic> json) {
    return SelectedItem(
        label: json['label'],
        value: json['value'],
        rowData: json['rowData'],
        isActive: false);
  }
}
