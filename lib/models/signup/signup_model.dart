class SignupModel {
  int? status;
  String? message;
  Data? data;

  SignupModel({this.status, this.message, this.data});

  SignupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? email;
  int? role;
  String? contactNumber;
  String? deviceId;
  String? deviceType;
  String? emailVerificationToken;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.name,
      this.email,
      this.role,
      this.contactNumber,
      this.deviceId,
      this.deviceType,
      this.emailVerificationToken,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
    contactNumber = json['contact_number'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    emailVerificationToken = json['email_verification_token'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['contact_number'] = this.contactNumber;
    data['device_id'] = this.deviceId;
    data['device_type'] = this.deviceType;
    data['email_verification_token'] = this.emailVerificationToken;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}