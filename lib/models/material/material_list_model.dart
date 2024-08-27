class MaterialListModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<MaterialItem>? data;

  MaterialListModel({this.status, this.message, this.pagination, this.data});

  MaterialListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <MaterialItem>[];
      json['data'].forEach((v) {
        data!.add(MaterialItem.fromJson(v));
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

class MaterialItem {
  int? id;
  String? skuNumber;
  String? name;
  int? categoryId;
  String? categoryName;
  String? description;
  int? mouId;
  String? mouValue;
  String? mouName;
  String? mouType;
  String? status;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  int? accountId;
  String? createdAt;
  String? updatedAt;

  MaterialItem(
      {this.id,
      this.skuNumber,
      this.name,
      this.categoryId,
      this.categoryName,
      this.description,
      this.mouId,
      this.mouValue,
      this.mouName,
      this.mouType,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.accountId,
      this.createdAt,
      this.updatedAt});

  MaterialItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skuNumber = json['sku_number'];
    name = json['name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    description = json['description'];
    mouId = json['mou_id'];
    mouValue = json['mou_value'];
    mouName = json['mou_name'];
    mouType = json['mou_type'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sku_number'] = skuNumber;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['description'] = description;
    data['mou_id'] = mouId;
    data['mou_value'] = mouValue;
    data['mou_name'] = mouName;
    data['mou_type'] = mouType;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['account_id'] = accountId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
