class EntityToEntityTransferNotification {
  int? status;
  String? message;
  Pagination? pagination;
  List<InternalRequest>? data;

  EntityToEntityTransferNotification(
      {this.status, this.message, this.pagination, this.data});

  EntityToEntityTransferNotification.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <InternalRequest>[];
      json['data'].forEach((v) {
        data!.add(InternalRequest.fromJson(v));
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

class InternalRequest {
  int? id;
  int? fromEntityType;
  int? toEntityType;
  int? fromEntityId;
  int? toEntityId;
  String? clientId;
  int? categoryId;
  int? materialId;
  int? unitId;
  int? quantity;
  String? binNumber;
  String? transactionDate;
  String? expiryDate;
  String? reason;
  String? note;
  String? status;
  String? images;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? validStart;
  String? validEnd;
  String? test;
  String? quantityType;
  String? senderEntity;
  String? receiverEntity;
  int? mouId;
  String? mouName;
  String? mouType;

  InternalRequest(
      {this.id,
      this.fromEntityType,
      this.toEntityType,
      this.fromEntityId,
      this.toEntityId,
      this.clientId,
      this.categoryId,
      this.materialId,
      this.unitId,
      this.quantity,
      this.binNumber,
      this.transactionDate,
      this.expiryDate,
      this.reason,
      this.note,
      this.status,
      this.images,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.accountId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.validStart,
      this.validEnd,
      this.test,
      this.quantityType,
      this.senderEntity,
      this.receiverEntity,
      this.mouId,
      this.mouName,
      this.mouType});

  InternalRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromEntityType = json['from_entity_type'];
    toEntityType = json['to_entity_type'];
    fromEntityId = json['from_entity_id'];
    toEntityId = json['to_entity_id'];
    clientId = json['client_id'];
    categoryId = json['category_id'];
    materialId = json['material_id'];
    unitId = json['unit_id'];
    quantity = json['quantity'];
    binNumber = json['bin_number'];
    transactionDate = json['transaction_date'];
    expiryDate = json['expiry_date'];
    reason = json['reason'];
    note = json['note'];
    status = json['status'];
    images = json['images'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    validStart = json['valid_start'];
    validEnd = json['valid_end'];
    test = json['test'];
    quantityType = json['quantity_type'];
    senderEntity = json['sender_entity'];
    receiverEntity = json['receiver_entity'];
    mouId = json['mou_id'];
    mouName = json['mou_name'];
    mouType = json['mou_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_entity_type'] = fromEntityType;
    data['to_entity_type'] = toEntityType;
    data['from_entity_id'] = fromEntityId;
    data['to_entity_id'] = toEntityId;
    data['client_id'] = clientId;
    data['category_id'] = categoryId;
    data['material_id'] = materialId;
    data['unit_id'] = unitId;
    data['quantity'] = quantity;
    data['bin_number'] = binNumber;
    data['transaction_date'] = transactionDate;
    data['expiry_date'] = expiryDate;
    data['reason'] = reason;
    data['note'] = note;
    data['status'] = status;
    data['images'] = images;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['account_id'] = accountId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['valid_start'] = validStart;
    data['valid_end'] = validEnd;
    data['test'] = test;
    data['quantity_type'] = quantityType;
    data['sender_entity'] = senderEntity;
    data['receiver_entity'] = receiverEntity;
    data['mou_id'] = mouId;
    data['mou_name'] = mouName;
    data['mou_type'] = mouType;
    return data;
  }
}
