class SortingModel {
  final String value;
  final String label;
  final String columnName;
  final String tableName;
  bool isAsc;
  bool isActive;

  SortingModel(
      {this.value,
      this.label,
      this.isAsc,
      this.isActive,
      this.columnName,
      this.tableName});
  Map toJson() {
    return {'columnName': columnName, 'tableName': tableName, 'isAsc': isAsc};
  }
}
