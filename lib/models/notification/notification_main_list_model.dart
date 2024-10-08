class NotificationMainListModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<NotificationItemData>? data;

  NotificationMainListModel(
      {this.status, this.message, this.pagination, this.data});

  NotificationMainListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <NotificationItemData>[];
      json['data'].forEach((v) {
        data!.add(NotificationItemData.fromJson(v));
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

class NotificationItemData {
  int? id;
  int? read;
  String? relationId;
  int? action;
  int? userId;
  int? actionCompleted;
  int? transactionStatusId;
  int? tranferId;
  int? accountsRelationId;
  String? title;
  String? description;
  DataNotification? dataNotification;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  NotificationItemData(
      {this.id,
      this.read,
      this.relationId,
      this.action,
      this.userId,
      this.actionCompleted,
      this.transactionStatusId,
      this.tranferId,
      this.accountsRelationId,
      this.title,
      this.description,
      this.dataNotification,
      this.accountId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  NotificationItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    read = json['read'];
    relationId = json['relation_id'];
    action = json['action'];
    userId = json['user_id'];
    actionCompleted = json['action_completed'];
    transactionStatusId = json['transaction_status_id'];
    tranferId = json['tranfer_id'];
    accountsRelationId = json['accounts_relation_id'];
    title = json['title'];
    description = json['description'];
    dataNotification = json['dataNotification'] != null
        ? DataNotification.fromJson(json['dataNotification'])
        : null;
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['read'] = read;
    data['relation_id'] = relationId;
    data['action'] = action;
    data['user_id'] = userId;
    data['action_completed'] = actionCompleted;
    data['transaction_status_id'] = transactionStatusId;
    data['tranfer_id'] = tranferId;
    data['accounts_relation_id'] = accountsRelationId;
    data['title'] = title;
    data['description'] = description;
    if (dataNotification != null) {
      data['dataNotification'] = dataNotification!.toJson();
    }
    data['account_id'] = accountId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class DataNotification {
  String? mainModule;
  String? subModule;
  String? entityName;
  String? entityId;
  String? entityType;
  String? toEntityName;
  String? toEntityId;
  String? toEntityType;
  String? transactionId;
  String? transactionDate;
  String? transactionType;
  String? vendorClientName;
  String? senderAccount;
  String? customerClientName;
  String? assetName;
  String? materialIncomingRequestId;
  String? internalTranferId;
  String? materialId;
  String? materialName;
  String? categoryId;
  String? categoryName;
  String? unitId;
  String? unitName;
  String? clientId;
  String? assetId;

  DataNotification(
      {this.mainModule,
      this.subModule,
      this.entityName,
      this.entityId,
      this.entityType,
      this.toEntityName,
      this.toEntityId,
      this.toEntityType,
      this.transactionId,
      this.transactionDate,
      this.transactionType,
      this.vendorClientName,
      this.senderAccount,
      this.customerClientName,
      this.assetName,
      this.materialIncomingRequestId,
      this.internalTranferId,
      this.materialId,
      this.materialName,
      this.categoryId,
      this.categoryName,
      this.unitId,
      this.unitName,
      this.clientId,
      this.assetId});

  DataNotification.fromJson(Map<String, dynamic> json) {
    mainModule = json['mainModule'];
    subModule = json['subModule'];
    entityName = json['entityName'];
    entityId = json['entityId'];
    entityType = json['entityType'];
    toEntityName = json['toEntityName'];
    toEntityId = json['toEntityId'];
    toEntityType = json['toEntityType'];
    transactionId = json['transactionId'];
    transactionDate = json['transactionDate'];
    transactionType = json['transactionType'];
    vendorClientName = json['vendorClientName'];
    senderAccount = json['senderAccount'];
    customerClientName = json['customerClientName'];
    assetName = json['assetName'];
    materialIncomingRequestId = json['material_incoming_request_id'];
    internalTranferId = json['internal_tranfer_id'];
    materialId = json['materialId'];
    materialName = json['materialName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    unitId = json['unitId'];
    unitName = json['unitName'];
    clientId = json['clientId'];
    assetId = json['asset_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mainModule'] = mainModule;
    data['subModule'] = subModule;
    data['entityName'] = entityName;
    data['entityId'] = entityId;
    data['entityType'] = entityType;
    data['toEntityName'] = toEntityName;
    data['toEntityId'] = toEntityId;
    data['toEntityType'] = toEntityType;
    data['transactionId'] = transactionId;
    data['transactionDate'] = transactionDate;
    data['transactionType'] = transactionType;
    data['vendorClientName'] = vendorClientName;
    data['senderAccount'] = senderAccount;
    data['customerClientName'] = customerClientName;
    data['assetName'] = assetName;
    data['material_incoming_request_id'] = materialIncomingRequestId;
    data['internal_tranfer_id'] = internalTranferId;
    data['materialId'] = materialId;
    data['materialName'] = materialName;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['unitId'] = unitId;
    data['unitName'] = unitName;
    data['clientId'] = clientId;
    data['asset_id'] = assetId;
    return data;
  }
}
