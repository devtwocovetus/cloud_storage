class MaterialInBinModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<Data>? data;

  MaterialInBinModel({this.status, this.message, this.pagination, this.data});

  MaterialInBinModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
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
  String? deletedBy;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? validFrom;
  String? validTo;
  String? typeOfStorageName;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
