class InventoryMaterialListModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<InventoryMaterial>? data;

  InventoryMaterialListModel(
      {this.status, this.message, this.pagination, this.data});

  InventoryMaterialListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <InventoryMaterial>[];
      json['data'].forEach((v) {
        data!.add(InventoryMaterial.fromJson(v));
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

class InventoryMaterial {
  int? materialId;
  int? categoryId;
  int? totalQuantity;
  String? materialName;
  String? categoryName;

  InventoryMaterial(
      {this.materialId,
      this.categoryId,
      this.totalQuantity,
      this.materialName,
      this.categoryName});

  InventoryMaterial.fromJson(Map<String, dynamic> json) {
    materialId = json['material_id'];
    categoryId = json['category_id'];
    totalQuantity = json['total_quantity'];
    materialName = json['material_name'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['material_id'] = materialId;
    data['category_id'] = categoryId;
    data['total_quantity'] = totalQuantity;
    data['material_name'] = materialName;
    data['category_name'] = categoryName;
    return data;
  }
}
