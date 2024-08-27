class MaterialTransferRequestModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<IncomingRequest>? data;

  MaterialTransferRequestModel(
      {this.status, this.message, this.pagination, this.data});

  MaterialTransferRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <IncomingRequest>[];
      json['data'].forEach((v) {
        data!.add(IncomingRequest.fromJson(v));
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

class IncomingRequest {
  int? id;
  int? transactionId;
  int? accepted;
  String? status;
  int? senderAccountClientId;
  int? senderAccountId;
  int? receiverAccountId;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? images;
  int? entityId;
  int? entityType;
  int? entityIdTo;
  int? entityTypeTo;
  int? quantityType;
  String? senderEntity;
  String? receiverEntity;
  int? senderEntityType;
  int? receiverEntityType;
  String? driverName;
  String? supplier;
  int? accountId;
  int? categoryId;
  String? categoryName;
  int? materialId;
  String? materialName;
  int? unitId;
  String? unitName;
  int? mouId;
  String? mouName;
  String? mouType;
  String? senderAccountClientName;
  String? senderAccount;
  String? receiverAccount;
  String? transactionDate;
  String? quantityTypeName;
  String? incomingTotalQuantity;

  IncomingRequest(
      {this.id,
      this.transactionId,
      this.accepted,
      this.status,
      this.senderAccountClientId,
      this.senderAccountId,
      this.receiverAccountId,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.images,
      this.entityId,
      this.entityType,
      this.entityIdTo,
      this.entityTypeTo,
      this.quantityType,
      this.senderEntity,
      this.receiverEntity,
      this.senderEntityType,
      this.receiverEntityType,
      this.driverName,
      this.supplier,
      this.accountId,
      this.categoryId,
      this.categoryName,
      this.materialId,
      this.materialName,
      this.unitId,
      this.unitName,
      this.mouId,
      this.mouName,
      this.mouType,
      this.senderAccountClientName,
      this.senderAccount,
      this.receiverAccount,
      this.transactionDate,
      this.quantityTypeName,
      this.incomingTotalQuantity});

  IncomingRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    accepted = json['accepted'];
    status = json['status'];
    senderAccountClientId = json['sender_account_client_id'];
    senderAccountId = json['sender_account_id'];
    receiverAccountId = json['receiver_account_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    images = json['images'];
    entityId = json['entity_id'];
    entityType = json['entity_type'];
    entityIdTo = json['entity_id_to'];
    entityTypeTo = json['entity_type_to'];
    quantityType = json['quantity_type'];
    senderEntity = json['sender_entity'];
    receiverEntity = json['receiver_entity'];
    senderEntityType = json['sender_entity_type'];
    receiverEntityType = json['receiver_entity_type'];
    driverName = json['driver_name'];
    supplier = json['supplier'];
    accountId = json['account_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    materialId = json['material_id'];
    materialName = json['material_name'];
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    mouId = json['mou_id'];
    mouName = json['mou_name'];
    mouType = json['mou_type'];
    senderAccountClientName = json['sender_account_client_name'];
    senderAccount = json['sender_account'];
    receiverAccount = json['receiver_account'];
    transactionDate = json['transaction_date'];
    quantityTypeName = json['quantity_type_name'];
    incomingTotalQuantity = json['incomingTotalQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_id'] = transactionId;
    data['accepted'] = accepted;
    data['status'] = status;
    data['sender_account_client_id'] = senderAccountClientId;
    data['sender_account_id'] = senderAccountId;
    data['receiver_account_id'] = receiverAccountId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['images'] = images;
    data['entity_id'] = entityId;
    data['entity_type'] = entityType;
    data['entity_id_to'] = entityIdTo;
    data['entity_type_to'] = entityTypeTo;
    data['quantity_type'] = quantityType;
    data['sender_entity'] = senderEntity;
    data['receiver_entity'] = receiverEntity;
    data['sender_entity_type'] = senderEntityType;
    data['receiver_entity_type'] = receiverEntityType;
    data['driver_name'] = driverName;
    data['supplier'] = supplier;
    data['account_id'] = accountId;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['material_id'] = materialId;
    data['material_name'] = materialName;
    data['unit_id'] = unitId;
    data['unit_name'] = unitName;
    data['mou_id'] = mouId;
    data['mou_name'] = mouName;
    data['mou_type'] = mouType;
    data['sender_account_client_name'] = senderAccountClientName;
    data['sender_account'] = senderAccount;
    data['receiver_account'] = receiverAccount;
    data['transaction_date'] = transactionDate;
    data['quantity_type_name'] = quantityTypeName;
    data['incomingTotalQuantity'] = incomingTotalQuantity;
    return data;
  }
}
