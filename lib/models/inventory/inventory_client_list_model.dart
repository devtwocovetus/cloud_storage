class InventoryClientListModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<InventoryClient>? data;

  InventoryClientListModel(
      {this.status, this.message, this.pagination, this.data});

  InventoryClientListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <InventoryClient>[];
      json['data'].forEach((v) {
        data!.add(InventoryClient.fromJson(v));
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

class InventoryClient {
  int? clientId;
  String? status;
  int? totalQuantity;
  int? totalMaterialCount;
  String? clientName;

  InventoryClient(
      {this.clientId,
      this.status,
      this.totalQuantity,
      this.totalMaterialCount,
      this.clientName});

  InventoryClient.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    status = json['status'];
    totalQuantity = json['total_quantity'];
    totalMaterialCount = json['total_material_count'];
    clientName = json['client_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_id'] = clientId;
    data['status'] = status;
    data['total_quantity'] = totalQuantity;
    data['total_material_count'] = totalMaterialCount;
    data['client_name'] = clientName;
    return data;
  }
}
