class UpdateProfileModel {
  int? status;
  String? message;
  Data? data;

  UpdateProfileModel({this.status, this.message, this.data});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? email;
  String? contactNumber;
  int? role;
  String? defaultLanguage;
  String? deviceId;
  String? deviceType;
  String? forgotPasswordValidateString;
  String? profileImage;
  String? emailVerified;
  String? emailVerifiedAt;
  String? firstTimeLogin;
  String? emailVerificationToken;
  String? status;
  String? accountId;
  String? setupCompleted;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? validStart;
  String? validEnd;

  Data(
      {this.id,
        this.name,
        this.firstName,
        this.lastName,
        this.email,
        this.contactNumber,
        this.role,
        this.defaultLanguage,
        this.deviceId,
        this.deviceType,
        this.forgotPasswordValidateString,
        this.profileImage,
        this.emailVerified,
        this.emailVerifiedAt,
        this.firstTimeLogin,
        this.emailVerificationToken,
        this.status,
        this.accountId,
        this.setupCompleted,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.validStart,
        this.validEnd});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    contactNumber = json['contact_number'];
    role = json['role'];
    defaultLanguage = json['default_language'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    forgotPasswordValidateString = json['forgot_password_validate_string'];
    profileImage = json['profile_image'];
    emailVerified = json['email_verified'];
    emailVerifiedAt = json['email_verified_at'];
    firstTimeLogin = json['first_time_login'];
    emailVerificationToken = json['email_verification_token'];
    status = json['status'];
    accountId = json['account_id'];
    setupCompleted = json['setup_completed'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    validStart = json['valid_start'];
    validEnd = json['valid_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['contact_number'] = contactNumber;
    data['role'] = role;
    data['default_language'] = defaultLanguage;
    data['device_id'] = deviceId;
    data['device_type'] = deviceType;
    data['forgot_password_validate_string'] = forgotPasswordValidateString;
    data['profile_image'] = profileImage;
    data['email_verified'] = emailVerified;
    data['email_verified_at'] = emailVerifiedAt;
    data['first_time_login'] = firstTimeLogin;
    data['email_verification_token'] = emailVerificationToken;
    data['status'] = status;
    data['account_id'] = accountId;
    data['setup_completed'] = setupCompleted;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['valid_start'] = validStart;
    data['valid_end'] = validEnd;
    return data;
  }
}
