class BaseItemModel {
  final String company_uuid;
  final String branch_uuid;
  final String create_by;
  final String update_by;
  final DateTime create_date;
  final DateTime update_date;

  BaseItemModel(
      {this.company_uuid,
      this.branch_uuid,
      this.create_by,
      this.update_by,
      this.create_date,
      this.update_date});
}
