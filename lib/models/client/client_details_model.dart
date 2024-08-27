class ClientDetailsModel {
  int? status;
  String? message;
  Data? data;

  ClientDetailsModel({this.status, this.message, this.data});

  ClientDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? relationId;
  ClientData? clientData;
  List<ClientEntityList>? clientEntityList;

  Data({this.relationId, this.clientData, this.clientEntityList});

  Data.fromJson(Map<String, dynamic> json) {
    relationId = json['relation_id'];
    clientData = json['client_data'] != null
        ? ClientData.fromJson(json['client_data'])
        : null;
    if (json['client_entity_list'] != null) {
      clientEntityList = <ClientEntityList>[];
      json['client_entity_list'].forEach((v) {
        clientEntityList!.add(ClientEntityList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['relation_id'] = relationId;
    if (clientData != null) {
      data['client_data'] = clientData!.toJson();
    }
    if (clientEntityList != null) {
      data['client_entity_list'] =
          clientEntityList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientData {
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
  int? referenceAccountId;
  String? manualCreation;
  String? pointsOfContact;
  String? pocPersonName;
  String? pocPersonEmail;
  String? pocPersonContactNumber;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  ClientData(
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
      this.pointsOfContact,
      this.pocPersonName,
      this.pocPersonEmail,
      this.pocPersonContactNumber,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ClientData.fromJson(Map<String, dynamic> json) {
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
    data['billing_address'] = billingAddress;
    data['status'] = status;
    data['reference_account_id'] = referenceAccountId;
    data['manual_creation'] = manualCreation;
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
    return data;
  }
}

class ClientEntityList {
  int? id;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? profileImage;
  String? location;
  String? capacity;
  String? temperatureMin;
  String? temperatureMax;
  String? humidityMin;
  String? humidityMax;
  String? ownerName;
  int? managerId;
  String? managerContactInformation;
  String? complianceCertificates;
  String? regulatoryInformation;
  String? safetyMeasures;
  String? alarms;
  String? temperatureMonitoringSystems;
  String? backupPowerSupply;
  String? operationalHoursStart;
  String? operationalHoursEnd;
  String? maintenanceSchedule;
  String? status;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? validFrom;
  String? validTo;
  String? managerName;
  String? managerEmail;
  String? managerContactNumber;
  int? entityType;
  List<EntityBinMaster>? entityBinMaster;

  ClientEntityList(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.phone,
      this.profileImage,
      this.location,
      this.capacity,
      this.temperatureMin,
      this.temperatureMax,
      this.humidityMin,
      this.humidityMax,
      this.ownerName,
      this.managerId,
      this.managerContactInformation,
      this.complianceCertificates,
      this.regulatoryInformation,
      this.safetyMeasures,
      this.alarms,
      this.temperatureMonitoringSystems,
      this.backupPowerSupply,
      this.operationalHoursStart,
      this.operationalHoursEnd,
      this.maintenanceSchedule,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.accountId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.validFrom,
      this.validTo,
      this.managerName,
      this.managerEmail,
      this.managerContactNumber,
      this.entityType,
      this.entityBinMaster});

  ClientEntityList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    profileImage = json['profile_image'];
    location = json['location'];
    capacity = json['capacity'];
    temperatureMin = json['temperature_min'];
    temperatureMax = json['temperature_max'];
    humidityMin = json['humidity_min'];
    humidityMax = json['humidity_max'];
    ownerName = json['owner_name'];
    managerId = json['manager_id'];
    managerContactInformation = json['manager_contact_information'];
    complianceCertificates = json['compliance_certificates'];
    regulatoryInformation = json['regulatory_information'];
    safetyMeasures = json['safety_measures'];
    alarms = json['alarms'];
    temperatureMonitoringSystems = json['temperature_monitoring_systems'];
    backupPowerSupply = json['backup_power_supply'];
    operationalHoursStart = json['operational_hours_start'];
    operationalHoursEnd = json['operational_hours_end'];
    maintenanceSchedule = json['maintenance_schedule'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    managerName = json['manager_name'];
    managerEmail = json['manager_email'];
    managerContactNumber = json['manager_contact_number'];
    entityType = json['entity_type'];
    if (json['entity_bin_master'] != null) {
      entityBinMaster = <EntityBinMaster>[];
      json['entity_bin_master'].forEach((v) {
        entityBinMaster!.add(EntityBinMaster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['profile_image'] = profileImage;
    data['location'] = location;
    data['capacity'] = capacity;
    data['temperature_min'] = temperatureMin;
    data['temperature_max'] = temperatureMax;
    data['humidity_min'] = humidityMin;
    data['humidity_max'] = humidityMax;
    data['owner_name'] = ownerName;
    data['manager_id'] = managerId;
    data['manager_contact_information'] = managerContactInformation;
    data['compliance_certificates'] = complianceCertificates;
    data['regulatory_information'] = regulatoryInformation;
    data['safety_measures'] = safetyMeasures;
    data['alarms'] = alarms;
    data['temperature_monitoring_systems'] = temperatureMonitoringSystems;
    data['backup_power_supply'] = backupPowerSupply;
    data['operational_hours_start'] = operationalHoursStart;
    data['operational_hours_end'] = operationalHoursEnd;
    data['maintenance_schedule'] = maintenanceSchedule;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['account_id'] = accountId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    data['manager_name'] = managerName;
    data['manager_email'] = managerEmail;
    data['manager_contact_number'] = managerContactNumber;
    data['entity_type'] = entityType;
    if (entityBinMaster != null) {
      data['entity_bin_master'] =
          entityBinMaster!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EntityBinMaster {
  int? id;
  int? entityId;
  String? binName;
  int? typeOfStorage;
  String? typeOfStorageOther;
  String? storageCondition;
  String? capacity;
  String? temperatureMin;
  String? temperatureMax;
  String? humidityMin;
  String? humidityMax;
  String? status;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? validFrom;
  String? validTo;
  String? typeOfStorageName;

  EntityBinMaster(
      {this.id,
      this.entityId,
      this.binName,
      this.typeOfStorage,
      this.typeOfStorageOther,
      this.storageCondition,
      this.capacity,
      this.temperatureMin,
      this.temperatureMax,
      this.humidityMin,
      this.humidityMax,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.accountId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.validFrom,
      this.validTo,
      this.typeOfStorageName});

  EntityBinMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entityId = json['entity_id'];
    binName = json['bin_name'];
    typeOfStorage = json['type_of_storage'];
    typeOfStorageOther = json['type_of_storage_other'];
    storageCondition = json['storage_condition'];
    capacity = json['capacity'];
    temperatureMin = json['temperature_min'];
    temperatureMax = json['temperature_max'];
    humidityMin = json['humidity_min'];
    humidityMax = json['humidity_max'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    typeOfStorageName = json['type_of_storage_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['entity_id'] = entityId;
    data['bin_name'] = binName;
    data['type_of_storage'] = typeOfStorage;
    data['type_of_storage_other'] = typeOfStorageOther;
    data['storage_condition'] = storageCondition;
    data['capacity'] = capacity;
    data['temperature_min'] = temperatureMin;
    data['temperature_max'] = temperatureMax;
    data['humidity_min'] = humidityMin;
    data['humidity_max'] = humidityMax;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['account_id'] = accountId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    data['type_of_storage_name'] = typeOfStorageName;
    return data;
  }
}
