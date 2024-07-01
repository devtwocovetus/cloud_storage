class UserListModel {
  int? status;
  String? message;
  Pagination? pagination;
  Data? data;

  UserListModel({this.status, this.message, this.pagination, this.data});

  UserListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? total;
  int? more;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? from;
  int? to;

  Pagination(
      {this.total,
      this.more,
      this.perPage,
      this.currentPage,
      this.lastPage,
      this.from,
      this.to});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    more = json['more'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['more'] = more;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}

class Data {
  List<Users>? users;
  CommonDetails? commonDetails;

  Data({this.users, this.commonDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
    commonDetails = json['commonDetails'] != null
        ? CommonDetails.fromJson(json['commonDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    if (commonDetails != null) {
      data['commonDetails'] = commonDetails!.toJson();
    }
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? email;
  String? contactNumber;
  int? role;
  String? deviceId;
  String? deviceType;
  String? forgotPasswordValidateString;
  String? profileImage;
  String? emailVerified;
  String? emailVerifiedAt;
  String? emailVerificationToken;
  String? status;
  int? accountId;
  String? setupCompleted;
  int? createdBy;
  int? updatedBy;
  String? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? validFrom;
  String? validTo;

  Users(
      {this.id,
      this.name,
      this.email,
      this.contactNumber,
      this.role,
      this.deviceId,
      this.deviceType,
      this.forgotPasswordValidateString,
      this.profileImage,
      this.emailVerified,
      this.emailVerifiedAt,
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
      this.validFrom,
      this.validTo});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNumber = json['contact_number'];
    role = json['role'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    forgotPasswordValidateString = json['forgot_password_validate_string'];
    profileImage = json['profile_image'];
    emailVerified = json['email_verified'];
    emailVerifiedAt = json['email_verified_at'];
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
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
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
    data['forgot_password_validate_string'] = forgotPasswordValidateString;
    data['profile_image'] = profileImage;
    data['email_verified'] = emailVerified;
    data['email_verified_at'] = emailVerifiedAt;
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
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    return data;
  }
}

class CommonDetails {
  int? userSubscriptionTableCount;
  int? usersLeftCount;
  int? currentCreatedUserCount;

  CommonDetails(
      {this.userSubscriptionTableCount,
      this.usersLeftCount,
      this.currentCreatedUserCount});

  CommonDetails.fromJson(Map<String, dynamic> json) {
    userSubscriptionTableCount = json['UserSubscriptionTableCount'];
    usersLeftCount = json['UsersLeftCount'];
    currentCreatedUserCount = json['CurrentCreatedUserCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserSubscriptionTableCount'] = userSubscriptionTableCount;
    data['UsersLeftCount'] = usersLeftCount;
    data['CurrentCreatedUserCount'] = currentCreatedUserCount;
    return data;
  }
}
