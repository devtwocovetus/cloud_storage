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
  int? category;
  String? description;
  String? mouValue;
  String? mouType;
  String? mou;
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
  String? categoryName;

  MaterialItem(
      {this.id,
      this.skuNumber,
      this.name,
      this.category,
      this.description,
      this.mouValue,
      this.mouType,
      this.mou,
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
      this.categoryName});

  MaterialItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skuNumber = json['sku_number'];
    name = json['name'];
    category = json['category'];
    description = json['description'];
    mouValue = json['mou_value'];
    mouType = json['mou_type'];
    mou = json['mou'];
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
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sku_number'] = skuNumber;
    data['name'] = name;
    data['category'] = category;
    data['description'] = description;
    data['mou_value'] = mouValue;
    data['mou_type'] = mouType;
    data['mou'] = mou;
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
    data['category_name'] = validTo;
    return data;
  }
}
