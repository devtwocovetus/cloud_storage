class PushNotificationData {
  String? mainModule;
  String? subModule;
  String? entityName;
  String? entityType;
  String? entityId;
  String? transactionId;
  String? assetId;
  String? assetName;
  String? materialIncomingRequestId;
  String? internalTranferId;
  String? toEntityName;
  String? toEntityId;
  String? toEntityType;
  String? materialId;
  String? materialName;
  String? categoryId;
  String? categoryName;
  String? unitId;
  String? unitName;
  String? clientId;
  String? transactionDate;
  String? transactionType;
  String? vendorClientName;
  String? senderAccount;
  String? customerClientName;  

  PushNotificationData(
      {this.mainModule,
      this.subModule,
      this.entityName,
      this.entityType,
      this.entityId,
      this.transactionId,
      this.assetId,
      this.assetName,
      this.materialIncomingRequestId,
      this.internalTranferId,
      this.toEntityName,
      this.toEntityId,
      this.toEntityType,
      this.materialId,
      this.materialName,
      this.categoryId,
      this.categoryName,
      this.unitId,
      this.unitName,
      this.clientId,
      this.customerClientName,
      this.senderAccount,
      this.transactionDate,
      this.transactionType,
      this.vendorClientName});

  PushNotificationData.fromJson(Map<String, dynamic> json) {
    mainModule = json['mainModule'];
    subModule = json['subModule'];
    entityName = json['entityName'];
    entityType = json['entityType'];
    entityId = json['entityId'];
    transactionId = json['transactionId'];
    assetId = json['assetId'];
    assetName = json['assetName'];
    materialIncomingRequestId = json['material_incoming_request_id'];
    internalTranferId = json['internal_tranfer_id'];
    toEntityName = json['toEntityName'];
    toEntityId = json['toEntityId'];
    toEntityType = json['toEntityType'];
    materialId = json['materialId'];
    materialName = json['materialName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    unitId = json['unitId'];
    unitName = json['unitName'];
    clientId = json['clientId'];
    customerClientName = json['customerClientName'];
    senderAccount = json['senderAccount'];
    transactionDate = json['transactionDate'];
    transactionType = json['transactionType'];
    vendorClientName = json['vendorClientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mainModule'] = mainModule;
    data['subModule'] = subModule;
    data['entityName'] = entityName;
    data['entityType'] = entityType;
    data['entityId'] = entityId;
    data['transactionId'] = transactionId;
    data['assetId'] = assetId;
    data['assetName'] = assetName;
    data['material_incoming_request_id'] = materialIncomingRequestId;
    data['internal_tranfer_id'] = internalTranferId;
    data['toEntityName'] = toEntityName;
    data['toEntityId'] = toEntityId;
    data['toEntityType'] = toEntityType;
    data['materialId'] = materialId;
    data['materialName'] = materialName;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['unitId'] = unitId;
    data['unitName'] = unitName;
    data['clientId'] = clientId;
    data['vendorClientName'] = vendorClientName;
    data['transactionType'] = transactionType;
    data['transactionDate'] = transactionDate;
    data['senderAccount'] = senderAccount;
    data['customerClientName'] = customerClientName;
    return data;
  }
}
