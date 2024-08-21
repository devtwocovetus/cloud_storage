class AssetListModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<AssetList>? data;

  AssetListModel({this.status, this.message, this.pagination, this.data});

  AssetListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <AssetList>[];
      json['data'].forEach((v) {
        data!.add(AssetList.fromJson(v));
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

class AssetList {
  int? id;
  int? assignmentId;
  String? assetName;
  int? category;
  String? endDate;
  String? currentLocationOrEntity;
  int? currentLocationOrEntityType;
  int? assignToUser;
  String? currentLocationOrEntityName;
  String? assignToUserName;
  String? assetAvailableStatus;

  AssetList(
      {this.id,
      this.assignmentId,
      this.assetName,
      this.category,
      this.endDate,
      this.currentLocationOrEntity,
      this.currentLocationOrEntityType,
      this.assignToUser,
      this.currentLocationOrEntityName,
      this.assignToUserName,
      this.assetAvailableStatus});

  AssetList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assignmentId = json['assignment_id'];
    assetName = json['asset_name'];
    category = json['category'];
    endDate = json['end_date'];
    currentLocationOrEntity = json['current_location_or_entity'];
    currentLocationOrEntityType = json['current_location_or_entity_type'];
    assignToUser = json['assign_to_user'];
    currentLocationOrEntityName = json['current_location_or_entity_name'];
    assignToUserName = json['assign_to_user_name'];
    assetAvailableStatus = json['asset_available_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['assignment_id'] = assignmentId;
    data['asset_name'] = assetName;
    data['category'] = category;
    data['end_date'] = endDate;
    data['current_location_or_entity'] = currentLocationOrEntity;
    data['current_location_or_entity_type'] = currentLocationOrEntityType;
    data['assign_to_user'] = assignToUser;
    data['current_location_or_entity_name'] = currentLocationOrEntityName;
    data['assign_to_user_name'] = assignToUserName;
    data['asset_available_status'] = assetAvailableStatus;
    return data;
  }
}
