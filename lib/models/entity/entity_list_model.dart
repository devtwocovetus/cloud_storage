class EntityListModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<Entity>? data;

  EntityListModel({this.status, this.message, this.pagination, this.data});

  EntityListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Entity>[];
      json['data'].forEach((v) {
        data!.add(Entity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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

class Entity {
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
  String? deletedBy;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? validFrom;
  String? validTo;
  List<EntityBinMaster>? entityBinMaster;
  int? entityType;
  String? farmSize;
  String? typeOfFarming;
  String? farmingMethod;
  String? irrigationSystem;
  String? soilType;
  String? storageFacilities;
  String? managerName;

  Entity(
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
      this.entityBinMaster,
      this.entityType,
      this.farmSize,
      this.typeOfFarming,
      this.farmingMethod,
      this.irrigationSystem,
      this.soilType,
      this.storageFacilities,
      this.managerName});

  Entity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    managerName = json['manager_name'];
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
    if (json['entity_bin_master'] != null) {
      entityBinMaster = <EntityBinMaster>[];
      json['entity_bin_master'].forEach((v) {
        entityBinMaster!.add(EntityBinMaster.fromJson(v));
      });
    }
    entityType = json['entity_type'];
    farmSize = json['farm_size'];
    typeOfFarming = json['type_of_farming'];
    farmingMethod = json['farming_method'];
    irrigationSystem = json['irrigation_system'];
    soilType = json['soil_type'];
    storageFacilities = json['storage_facilities'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['manager_name'] = managerName;
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
    if (entityBinMaster != null) {
      data['entity_bin_master'] =
          entityBinMaster!.map((v) => v.toJson()).toList();
    }
    data['entity_type'] = entityType;
    data['farm_size'] = farmSize;
    data['type_of_farming'] = typeOfFarming;
    data['farming_method'] = farmingMethod;
    data['irrigation_system'] = irrigationSystem;
    data['soil_type'] = soilType;
    data['storage_facilities'] = storageFacilities;
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
  Null? deletedAt;
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
