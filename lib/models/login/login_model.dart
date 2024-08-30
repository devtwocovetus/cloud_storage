class LoginModel {
  int? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? contactNumber;
  int? role;
  String? defaultLanguage;
  String? deviceId;
  String? deviceType;
  int? emailVerified;
  int? setupCompleted;
  int? status;
  String? createdAt;
  String? updatedAt;
  bool? accountExist;
  String? token;
  int? currentAccountStatus;
  int? firstTimeLogin;
  List<Permissions>? permissions;

  Data(
      {this.id,
      this.name,
      this.email,
      this.contactNumber,
      this.role,
      this.defaultLanguage,
      this.deviceId,
      this.deviceType,
      this.emailVerified,
      this.setupCompleted,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.accountExist,
      this.token,
      this.currentAccountStatus,
      this.firstTimeLogin,
      this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNumber = json['contact_number'];
    role = json['role'];
    defaultLanguage = json['default_language'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    emailVerified = json['email_verified'];
    setupCompleted = json['setup_completed'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    accountExist = json['accountExist'];
    token = json['token'];
    currentAccountStatus = json['current_account_status'];
    firstTimeLogin = json['firstTimeLogin'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['contact_number'] = contactNumber;
    data['role'] = role;
    data['default_language'] = defaultLanguage;
    data['device_id'] = deviceId;
    data['device_type'] = deviceType;
    data['email_verified'] = emailVerified;
    data['setup_completed'] = setupCompleted;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['accountExist'] = accountExist;
    data['token'] = token;
    data['current_account_status'] = currentAccountStatus;
    data['firstTimeLogin'] = firstTimeLogin;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  int? id;
  String? name;
  String? moduleName;
  String? description;
  bool? status;

  Permissions(
      {this.id, this.name, this.moduleName, this.description, this.status});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    moduleName = json['module_name'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['module_name'] = moduleName;
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}
