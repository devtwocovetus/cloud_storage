class LoginModel {
  int? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

  Data(
      {this.id,
      this.name,
      this.email,
      this.contactNumber,
      this.role,
      this.deviceId,
      this.deviceType,
      this.emailVerified,
      this.setupCompleted,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.accountExist,
      this.token,
      this.currentAccountStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNumber = json['contact_number'];
    role = json['role'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['contact_number'] = contactNumber;
    data['role'] = role;
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
    return data;
  }
}