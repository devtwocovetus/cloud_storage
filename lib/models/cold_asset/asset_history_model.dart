class AssetHistoryModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<History>? data;

  AssetHistoryModel({this.status, this.message, this.pagination, this.data});

  AssetHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <History>[];
      json['data'].forEach((v) {
        data!.add(History.fromJson(v));
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

class History {
  int? id;
  int? assetId;
  int? fromLocationOrEntity;
  int? fromLocationOrEntityType;
  int? toLocationOrEntity;
  int? toLocationOrEntityType;
  int? assignToUser;
  String? usages;
  String? note;
  String? startDate;
  String? endDate;
  String? status;
  String? assetReleased;
  int? createdBy;
  String? updatedBy;
  String? deletedBy;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? validFrom;
  String? validTo;
  String? fromLocationOrEntityName;
  String? toLocationOrEntityName;
  String? assignToUserName;
  String? assignedBy;

  History(
      {this.id,
      this.assetId,
      this.fromLocationOrEntity,
      this.fromLocationOrEntityType,
      this.toLocationOrEntity,
      this.toLocationOrEntityType,
      this.assignToUser,
      this.usages,
      this.note,
      this.startDate,
      this.endDate,
      this.status,
      this.assetReleased,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.accountId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.validFrom,
      this.validTo,
      this.fromLocationOrEntityName,
      this.toLocationOrEntityName,
      this.assignToUserName,
      this.assignedBy});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assetId = json['asset_id'];
    fromLocationOrEntity = json['from_location_or_entity'];
    fromLocationOrEntityType = json['from_location_or_entity_type'];
    toLocationOrEntity = json['to_location_or_entity'];
    toLocationOrEntityType = json['to_location_or_entity_type'];
    assignToUser = json['assign_to_user'];
    usages = json['usages'];
    note = json['note'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    assetReleased = json['asset_released'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    fromLocationOrEntityName = json['from_location_or_entity_name'];
    toLocationOrEntityName = json['to_location_or_entity_name'];
    assignToUserName = json['assign_to_user_name'];
    assignedBy = json['assigned_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['asset_id'] = assetId;
    data['from_location_or_entity'] = fromLocationOrEntity;
    data['from_location_or_entity_type'] = fromLocationOrEntityType;
    data['to_location_or_entity'] = toLocationOrEntity;
    data['to_location_or_entity_type'] = toLocationOrEntityType;
    data['assign_to_user'] = assignToUser;
    data['usages'] = usages;
    data['note'] = note;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    data['asset_released'] = assetReleased;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['account_id'] = accountId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    data['from_location_or_entity_name'] = fromLocationOrEntityName;
    data['to_location_or_entity_name'] = toLocationOrEntityName;
    data['assign_to_user_name'] = assignToUserName;
    data['assigned_by'] = assignedBy;
    return data;
  }
}
