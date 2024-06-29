class AccountCreateModel {
  int? status;
  String? message;
  Data? data;

  AccountCreateModel({this.status, this.message, this.data});

  AccountCreateModel.fromJson(Map<String, dynamic> json) {
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
  Account? account;
  List<AccountUserRelation>? accountUserRelation;

  Data({this.account, this.accountUserRelation});

  Data.fromJson(Map<String, dynamic> json) {
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
    if (json['account_user_relation'] != null) {
      accountUserRelation = <AccountUserRelation>[];
      json['account_user_relation'].forEach((v) {
        accountUserRelation!.add(AccountUserRelation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (account != null) {
      data['account'] = account!.toJson();
    }
    if (accountUserRelation != null) {
      data['account_user_relation'] =
          accountUserRelation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Account {
  int? id;
  String? name;
  String? email;
  String? contactNumber;
  String? street1;
  String? street2;
  String? country;
  String? state;
  String? city;
  String? postalCode;
  String? defaultLanguage;
  String? timezone;
  String? dateFormat;
  String? timeFormat;
  String? billingCycle;
  String? selectUnit;
  String? logo;
  String? description;
  String? differentBillingAddress;
  String? billingAddress;
  String? status;
  String? referenceAccountId;
  String? manualCreation;
  int? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Account(
      {this.id,
      this.name,
      this.email,
      this.contactNumber,
      this.street1,
      this.street2,
      this.country,
      this.state,
      this.city,
      this.postalCode,
      this.defaultLanguage,
      this.timezone,
      this.dateFormat,
      this.timeFormat,
      this.billingCycle,
      this.selectUnit,
      this.logo,
      this.description,
      this.differentBillingAddress,
      this.billingAddress,
      this.status,
      this.referenceAccountId,
      this.manualCreation,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNumber = json['contact_number'];
    street1 = json['street1'];
    street2 = json['street2'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    postalCode = json['postal_code'];
    defaultLanguage = json['default_language'];
    timezone = json['timezone'];
    dateFormat = json['date_format'];
    timeFormat = json['time_format'];
    billingCycle = json['billing_cycle'];
    selectUnit = json['select_unit'];
    logo = json['logo'];
    description = json['description'];
    differentBillingAddress = json['different_billing_address'];
    billingAddress = json['billing_address'];
    status = json['status'];
    referenceAccountId = json['reference_account_id'];
    manualCreation = json['manual_creation'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['contact_number'] = contactNumber;
    data['street1'] = street1;
    data['street2'] = street2;
    data['country'] =country;
    data['state'] = state;
    data['city'] = city;
    data['postal_code'] = postalCode;
    data['default_language'] = defaultLanguage;
    data['timezone'] = timezone;
    data['date_format'] = dateFormat;
    data['time_format'] = timeFormat;
    data['billing_cycle'] = billingCycle;
    data['select_unit'] = selectUnit;
    data['logo'] = logo;
    data['description'] = description;
    data['different_billing_address'] = differentBillingAddress;
    data['billing_address'] = billingAddress;
    data['status'] = status;
    data['reference_account_id'] = referenceAccountId;
    data['manual_creation'] = manualCreation;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class AccountUserRelation {
  int? id;
  int? accountId;
  int? userId;
  int? userRole;
  String? status;
  int? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  AccountUserRelation(
      {this.id,
      this.accountId,
      this.userId,
      this.userRole,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  AccountUserRelation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'];
    userId = json['user_id'];
    userRole = json['user_role'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['account_id'] = accountId;
    data['user_id'] = userId;
    data['user_role'] = userRole;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
