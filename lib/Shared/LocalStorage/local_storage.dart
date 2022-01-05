import 'package:ice_fac_mobile/ViewModel/local_storage_item_view.dart';
import 'package:localstorage/localstorage.dart';

class LocalStorageCustom {
  bool isLoggedIn() {
    String token = getAccess_token();
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  final LocalStorage storage = new LocalStorage('icefac_app');
  // String storageName = 'storageName';
  // String companyUUID = 'companyUUID';
  // String departmentUUID = 'departmentUUID';
  // String branchUUID = 'branchUUID';
  // String accessToken = 'accessToken';
  // String accessRight = 'accessRight';
  // String userId = 'userId';
  // String userImg = 'userImg';
  // String employeeUUID = 'employeeUUID';

  String correct_password = 'correct_password';
  String user_name = 'user_name';
  String employee_uuid = 'employee_uuid';
  String role_uuid = 'role_uuid';
  String company_uuid = 'company_uuid';
  String branch_uuid = 'branch_uuid';
  String is_active = 'is_active';
  String create_by = 'create_by';
  String create_date = 'create_date';
  String update_by = 'update_by';
  String update_date = 'update_date';
  String ref_uuid = 'ref_uuid';
  String ref_type = 'ref_type';
  String languageid = 'languageid';
  String subscribe_uuid = 'subscribe_uuid';
  String department_uuid = 'department_uuid';
  String refresh_token = 'refresh_token';
  String access_token = 'access_token';

  LocalStorageCustom();

  String getCorrect_password() {
    return storage.getItem(this.correct_password);
  }

  String getUser_name() {
    return storage.getItem(this.user_name);
  }

  String getEmployee_uuid() {
    return storage.getItem(this.employee_uuid);
  }

  String getRole_uuid() {
    return storage.getItem(this.role_uuid);
  }

  String getCompany_uuid() {
    return storage.getItem(this.company_uuid);
  }

  String getBranch_uuid() {
    return storage.getItem(this.branch_uuid);
  }

  String getIs_active() {
    return storage.getItem(this.is_active);
  }

  String getCreate_by() {
    return storage.getItem(this.create_by);
  }

  String getCreate_date() {
    return storage.getItem(this.create_date);
  }

  String getUpdate_by() {
    return storage.getItem(this.update_by);
  }

  String getUpdate_date() {
    return storage.getItem(this.update_date);
  }

  String getRef_uuid() {
    return storage.getItem(this.ref_uuid);
  }

  String getRef_type() {
    return storage.getItem(this.ref_type);
  }

  String getLanguageid() {
    return storage.getItem(this.languageid);
  }

  String getSubscribe_uuid() {
    return storage.getItem(this.subscribe_uuid);
  }

  String getDepartment_uuid() {
    return storage.getItem(this.department_uuid);
  }

  String getRefresh_token() {
    return storage.getItem(this.refresh_token);
  }

  String getAccess_token() {
    return storage.getItem(this.access_token);
  }

  setCorrect_password(String value) {
    storage.setItem(this.correct_password, value);
  }

  setUser_name(String value) {
    storage.setItem(this.user_name, value);
  }

  setEmployee_uuid(String value) {
    storage.setItem(this.employee_uuid, value);
  }

  setRole_uuid(String value) {
    storage.setItem(this.role_uuid, value);
  }

  setCompany_uuid(String value) {
    storage.setItem(this.company_uuid, value);
  }

  setBranch_uuid(String value) {
    storage.setItem(this.branch_uuid, value);
  }

  setIs_active(bool value) {
    storage.setItem(this.is_active, value);
  }

  setCreate_by(String value) {
    storage.setItem(this.create_by, value);
  }

  setCreate_date(String value) {
    storage.setItem(this.create_date, value);
  }

  setUpdate_by(String value) {
    storage.setItem(this.update_by, value);
  }

  setUpdate_date(String value) {
    storage.setItem(this.update_date, value);
  }

  setRef_uuid(String value) {
    storage.setItem(this.ref_uuid, value);
  }

  setRef_type(String value) {
    storage.setItem(this.ref_type, value);
  }

  setLanguageid(String value) {
    storage.setItem(this.languageid, value);
  }

  setSubscribe_uuid(String value) {
    storage.setItem(this.subscribe_uuid, value);
  }

  setDepartment_uuid(String value) {
    storage.setItem(this.department_uuid, value);
  }

  setRefresh_token(String value) {
    storage.setItem(this.refresh_token, value);
  }

  setAccess_token(String value) {
    storage.setItem(this.access_token, value);
  }

  setDataLogin(LocalStorageItemView itemView) async {
    await storage.setItem(this.correct_password, itemView.correct_password);
    await storage.setItem(this.user_name, itemView.user_name);
    await storage.setItem(this.employee_uuid, itemView.employee_uuid);
    await storage.setItem(this.role_uuid, itemView.role_uuid);
    await storage.setItem(this.company_uuid, itemView.company_uuid);
    await storage.setItem(this.branch_uuid, itemView.branch_uuid);
    await storage.setItem(this.is_active, itemView.is_active);
    await storage.setItem(this.create_by, itemView.create_by);
    await storage.setItem(this.create_date, itemView.create_date);
    await storage.setItem(this.update_by, itemView.update_by);
    await storage.setItem(this.update_date, itemView.update_date);
    await storage.setItem(this.ref_uuid, itemView.ref_uuid);
    await storage.setItem(this.ref_type, itemView.ref_type);
    await storage.setItem(this.languageid, itemView.languageid);
    await storage.setItem(this.subscribe_uuid, itemView.subscribe_uuid);
    await storage.setItem(this.department_uuid, itemView.department_uuid);
    await storage.setItem(this.refresh_token, itemView.refresh_token);
    await storage.setItem(this.access_token, itemView.access_token);
  }
}
