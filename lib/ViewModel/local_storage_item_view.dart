class LocalStorageItemView {
  final String correct_password;
  final String user_name;
  final String employee_uuid;
  final String role_uuid;
  final String company_uuid;
  final String branch_uuid;
  final bool is_active;
  final String create_by;
  final String create_date;
  final String update_by;
  final String update_date;
  final String ref_uuid;
  final String ref_type;
  final String languageid;
  final String subscribe_uuid;
  final String department_uuid;
  final String refresh_token;
  final String access_token;

  LocalStorageItemView(
      {this.correct_password,
      this.user_name,
      this.employee_uuid,
      this.role_uuid,
      this.company_uuid,
      this.branch_uuid,
      this.is_active,
      this.create_by,
      this.create_date,
      this.update_by,
      this.update_date,
      this.ref_uuid,
      this.ref_type,
      this.languageid,
      this.subscribe_uuid,
      this.department_uuid,
      this.refresh_token,
      this.access_token});
  factory LocalStorageItemView.fromJson(Map<dynamic, dynamic> json) {
    return LocalStorageItemView(
      correct_password: json['correct_password'],
      user_name: json['user_name'],
      employee_uuid: json['employee_uuid'],
      role_uuid: json['role_uuid'],
      company_uuid: json['company_uuid'],
      branch_uuid: json['branch_uuid'],
      is_active: json['is_active'],
      create_by: json['create_by'],
      create_date: json['create_date'],
      update_by: json['update_by'],
      update_date: json['update_date'],
      ref_uuid: json['ref_uuid'],
      ref_type: json['ref_type'],
      languageid: json['languageid'],
      subscribe_uuid: json['subscribe_uuid'],
      department_uuid: json['department_uuid'],
      refresh_token: json['refresh_token'],
      access_token: json['access_token'],
    );
  }
}
