class GlobalClientListModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<Client>? clientList;

  GlobalClientListModel(
      {this.status, this.message, this.pagination, this.clientList});

  GlobalClientListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      clientList = <Client>[];
      json['data'].forEach((v) {
        clientList!.add(Client.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (clientList != null) {
      data['data'] = clientList!.map((v) => v.toJson()).toList();
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

class Client {
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
  String? billingAddressStreet1;
  String? billingAddressStreet2;
  String? billingAddressCountry;
  String? billingAddressState;
  String? billingAddressCity;
  String? billingAddressPostalCode;
  String? status;
  int? referenceAccountId;
  String? manualCreation;
  int? userType;
  int? pointsOfContact;
  String? pocPersonName;
  String? pocPersonEmail;
  String? pocPersonContactNumber;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? relationId;
  int? requestIncoming;
  int? requestSent;
  int? incomingRequestAccepted;
  int? outgoingRequestAccepted;
  int? incomingRequestRejected;
  int? outgoingRequestRejected;
  int? hasRequest;
  int? hasInventory;

  Client(
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
        this.billingAddressStreet1,
        this.billingAddressStreet2,
        this.billingAddressCountry,
        this.billingAddressState,
        this.billingAddressCity,
        this.billingAddressPostalCode,
        this.status,
        this.referenceAccountId,
        this.manualCreation,
        this.userType,
        this.pointsOfContact,
        this.pocPersonName,
        this.pocPersonEmail,
        this.pocPersonContactNumber,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.relationId,
        this.requestIncoming,
        this.requestSent,
        this.incomingRequestAccepted,
        this.outgoingRequestAccepted,
        this.incomingRequestRejected,
        this.outgoingRequestRejected,
        this.hasRequest,
        this.hasInventory});

  Client.fromJson(Map<String, dynamic> json) {
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
    billingAddressStreet1 = json['billing_address_street1'];
    billingAddressStreet2 = json['billing_address_street2'];
    billingAddressCountry = json['billing_address_country'];
    billingAddressState = json['billing_address_state'];
    billingAddressCity = json['billing_address_city'];
    billingAddressPostalCode = json['billing_address_postal_code'];
    status = json['status'];
    referenceAccountId = json['reference_account_id'];
    manualCreation = json['manual_creation'];
    userType = json['user_type'];
    pointsOfContact = json['points_of_contact'];
    pocPersonName = json['poc_person_name'];
    pocPersonEmail = json['poc_person_email'];
    pocPersonContactNumber = json['poc_person_contact_number'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    relationId = json['relation_id'];
    requestIncoming = json['request_incoming'];
    requestSent = json['request_sent'];
    incomingRequestAccepted = json['incoming_request_accepted'];
    outgoingRequestAccepted = json['outgoing_request_accepted'];
    incomingRequestRejected = json['incoming_request_rejected'];
    outgoingRequestRejected = json['outgoing_request_rejected'];
    hasRequest = json['has_request'];
    hasInventory = json['has_inventory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['contact_number'] = contactNumber;
    data['street1'] = street1;
    data['street2'] = street2;
    data['country'] = country;
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
    data['billing_address_street1'] = billingAddressStreet1;
    data['billing_address_street2'] = billingAddressStreet2;
    data['billing_address_country'] = billingAddressCountry;
    data['billing_address_state'] = billingAddressState;
    data['billing_address_city'] = billingAddressCity;
    data['billing_address_postal_code'] = billingAddressPostalCode;
    data['status'] = status;
    data['reference_account_id'] = referenceAccountId;
    data['manual_creation'] = manualCreation;
    data['user_type'] = userType;
    data['points_of_contact'] = pointsOfContact;
    data['poc_person_name'] = pocPersonName;
    data['poc_person_email'] = pocPersonEmail;
    data['poc_person_contact_number'] = pocPersonContactNumber;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['relation_id'] = relationId;
    data['request_incoming'] = requestIncoming;
    data['request_sent'] = requestSent;
    data['incoming_request_accepted'] = incomingRequestAccepted;
    data['outgoing_request_accepted'] = outgoingRequestAccepted;
    data['incoming_request_rejected'] = incomingRequestRejected;
    data['outgoing_request_rejected'] = outgoingRequestRejected;
    data['has_request'] = hasRequest;
    data['has_inventory'] = hasInventory;
    return data;
  }
}
