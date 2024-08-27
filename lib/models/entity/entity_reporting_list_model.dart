class EntityReportingListModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<EntityReport>? data;

  EntityReportingListModel(
      {this.status, this.message, this.pagination, this.data});

  EntityReportingListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <EntityReport>[];
      json['data'].forEach((v) {
        data!.add(EntityReport.fromJson(v));
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

class EntityReport {
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
  int? entityReportCycleRelationId;
  int? reportingCycleIdDaily;
  int? reportingCycleIdWeekly;
  int? reportingCycleIdMonthly;
  int? entityType;

  EntityReport(
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
      this.entityReportCycleRelationId,
      this.reportingCycleIdDaily,
      this.reportingCycleIdWeekly,
      this.reportingCycleIdMonthly,
      this.entityType});

  EntityReport.fromJson(Map<String, dynamic> json) {
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
    entityReportCycleRelationId = json['entity_report_cycle_relation_id'];
    reportingCycleIdDaily = json['reporting_cycle_id_daily'];
    reportingCycleIdWeekly = json['reporting_cycle_id_weekly'];
    reportingCycleIdMonthly = json['reporting_cycle_id_monthly'];
    entityType = json['entity_type'];
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
    data['entity_report_cycle_relation_id'] = entityReportCycleRelationId;
    data['reporting_cycle_id_daily'] = reportingCycleIdDaily;
    data['reporting_cycle_id_weekly'] = reportingCycleIdWeekly;
    data['reporting_cycle_id_monthly'] = reportingCycleIdMonthly;
    data['entity_type'] = entityType;
    return data;
  }
}
