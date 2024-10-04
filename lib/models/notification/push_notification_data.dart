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
  String? businessRequestSenderId;
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
  bool? clientIsRequest;
  String? clientIsManual;
  bool? requestSent;
  bool? outgoingRequestAccepted;
  bool? requestIncoming;
  bool? incomingRequestAccepted;

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
      this.businessRequestSenderId,
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
      this.clientIsRequest,
      this.clientIsManual,
      this.requestSent,
      this.outgoingRequestAccepted,
      this.requestIncoming,
      this.incomingRequestAccepted});

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
    businessRequestSenderId = json['business_request_sender_id'];
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
    clientIsRequest = json['clientIsRequest'];
    clientIsManual = json['clientIsManual'];
    requestSent = json['requestSent'];
    outgoingRequestAccepted = json['outgoingRequestAccepted'];
    requestIncoming = json['requestIncoming'];
    incomingRequestAccepted = json['incomingRequestAccepted'];
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
    data['business_request_sender_id'] = businessRequestSenderId;
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
    data['clientIsRequest'] = clientIsRequest;
    data['clientIsManual'] = clientIsManual;
    data['requestSent'] = requestSent;
    data['outgoingRequestAccepted'] = outgoingRequestAccepted;
    data['requestIncoming'] = requestIncoming;
    data['incomingRequestAccepted'] = incomingRequestAccepted;
    return data;
  }
}
