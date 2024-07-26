class InventoryUnitsListModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<Data>? data;

  InventoryUnitsListModel(
      {this.status, this.message, this.pagination, this.data});

  InventoryUnitsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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
  int? unitId;
  String? unitName;
  int? quantityType;
  String? quantityTypeName;
  int? totalQuantity;
  int? categoryId;
  String? categoryName;
  int? materialId;
  String? materialName;
  String? mouId;
  String? mouName;
  String? mouType;

  Data(
      {this.unitId,
      this.unitName,
      this.quantityType,
      this.quantityTypeName,
      this.totalQuantity,
      this.categoryId,
      this.categoryName,
      this.materialId,
      this.materialName,
      this.mouId,
      this.mouName,
      this.mouType});

  Data.fromJson(Map<String, dynamic> json) {
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    quantityType = json['quantity_type'];
    quantityTypeName = json['quantity_type_name'];
    totalQuantity = json['total_quantity'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    materialId = json['material_id'];
    materialName = json['material_name'];
    mouId = json['mou_id'];
    mouName = json['mou_name'];
    mouType = json['mou_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unit_id'] = unitId;
    data['unit_name'] = unitName;
    data['quantity_type'] = quantityType;
    data['quantity_type_name'] = quantityTypeName;
    data['total_quantity'] = totalQuantity;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['material_id'] = materialId;
    data['material_name'] = materialName;
    data['mou_id'] = mouId;
    data['mou_name'] = mouName;
    data['mou_type'] = mouType;
    return data;
  }
}
