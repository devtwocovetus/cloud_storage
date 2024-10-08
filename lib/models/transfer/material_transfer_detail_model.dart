class MaterialTransferDetailModel {
  int? status;
  String? message;
  Data? data;

  MaterialTransferDetailModel({this.status, this.message, this.data});

  MaterialTransferDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  CommonData? commonData;
  List<IncomingMaterials>? incomingMaterials;

  Data({this.commonData, this.incomingMaterials});

  Data.fromJson(Map<String, dynamic> json) {
    commonData = json['commonData'] != null
        ? CommonData.fromJson(json['commonData'])
        : null;
    if (json['incomingMaterials'] != null) {
      incomingMaterials = <IncomingMaterials>[];
      json['incomingMaterials'].forEach((v) {
        incomingMaterials!.add(IncomingMaterials.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (commonData != null) {
      data['commonData'] = commonData!.toJson();
    }
    if (incomingMaterials != null) {
      data['incomingMaterials'] =
          incomingMaterials!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommonData {
  String? transactionStatusId;
  String? supplierAccount;
  String? supplierClient;
  int? receiverAccountId;
  String? receiverAccountName;
  int? entityType;
  String? entityTypeName;
  int? entityId;
  String? entityIdName;
  String? transactionDate;
  int? incomingTotalQuantity;
  String? driverName;

  CommonData(
      {this.transactionStatusId,
      this.supplierAccount,
      this.supplierClient,
      this.receiverAccountId,
      this.receiverAccountName,
      this.entityType,
      this.entityTypeName,
      this.entityId,
      this.entityIdName,
      this.transactionDate,
      this.incomingTotalQuantity,
      this.driverName});

  CommonData.fromJson(Map<String, dynamic> json) {
    transactionStatusId = json['transaction_status_id'];
    supplierAccount = json['supplier_account'];
    supplierClient = json['supplier_client'];
    receiverAccountId = json['receiver_account_id'];
    receiverAccountName = json['receiver_account_name'];
    entityType = json['entityType'];
    entityTypeName = json['entityTypeName'];
    entityId = json['entityId'];
    entityIdName = json['entityIdName'];
    transactionDate = json['transactionDate'];
    incomingTotalQuantity = json['incomingTotalQuantity'];
    driverName = json['driverName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_status_id'] = transactionStatusId;
    data['supplier_account'] = supplierAccount;
    data['supplier_client'] = supplierClient;
    data['receiver_account_id'] = receiverAccountId;
    data['receiver_account_name'] = receiverAccountName;
    data['entityType'] = entityType;
    data['entityTypeName'] = entityTypeName;
    data['entityId'] = entityId;
    data['entityIdName'] = entityIdName;
    data['transactionDate'] = transactionDate;
    data['incomingTotalQuantity'] = incomingTotalQuantity;
    data['driverName'] = driverName;
    return data;
  }
}

class IncomingMaterials {
  int? id;
  int? transactionStatusId;
  int? transactionId;
  int? transactionDetailId;
  int? quantity;
  int? entityIdTo;
  int? entityTypeTo;
  int? customerId;
  int? senderAccountId;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? validStart;
  String? validEnd;
  int? receiverAccountId;
  String? categoryName;
  String? materialName;
  String? unitName;
  String? driverName;
  int? mouId;
  String? mouName;
  String? mouType;
  int? categoryId;
  int? materialId;
  int? unitId;
  int? breakageQuantity;
  String? binNumber;
  String? expiryDate;
  String? transactionDate;
  int? entityId;
  int? entityType;
  String? clientId;
  String? transactionType;
  String? transferType;
  String? images;
  String? notes;
  int? transferId;
  String? entityName;

  IncomingMaterials(
      {this.id,
      this.transactionStatusId,
      this.transactionId,
      this.transactionDetailId,
      this.quantity,
      this.entityIdTo,
      this.entityTypeTo,
      this.customerId,
      this.senderAccountId,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.accountId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.validStart,
      this.validEnd,
      this.receiverAccountId,
      this.categoryName,
      this.materialName,
      this.unitName,
      this.driverName,
      this.mouId,
      this.mouName,
      this.mouType,
      this.categoryId,
      this.materialId,
      this.unitId,
      this.breakageQuantity,
      this.binNumber,
      this.expiryDate,
      this.transactionDate,
      this.entityId,
      this.entityType,
      this.clientId,
      this.transactionType,
      this.transferType,
      this.images,
      this.notes,
      this.transferId,
      this.entityName});

  IncomingMaterials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionStatusId = json['transaction_status_id'];
    transactionId = json['transaction_id'];
    transactionDetailId = json['transaction_detail_id'];
    quantity = json['quantity'];
    entityIdTo = json['entity_id_to'];
    entityTypeTo = json['entity_type_to'];
    customerId = json['customer_id'];
    senderAccountId = json['sender_account_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    validStart = json['valid_start'];
    validEnd = json['valid_end'];
    receiverAccountId = json['receiver_account_id'];
    categoryName = json['category_name'];
    materialName = json['material_name'];
    unitName = json['unit_name'];
    driverName = json['driver_name'];
    mouId = json['mou_id'];
    mouName = json['mou_name'];
    mouType = json['mou_type'];
    categoryId = json['category_id'];
    materialId = json['material_id'];
    unitId = json['unit_id'];
    breakageQuantity = json['breakage_quantity'];
    binNumber = json['bin_number'];
    expiryDate = json['expiry_date'];
    transactionDate = json['transaction_date'];
    entityId = json['entity_id'];
    entityType = json['entity_type'];
    clientId = json['client_id'];
    transactionType = json['transaction_type'];
    transferType = json['transfer_type'];
    images = json['images'];
    notes = json['notes'];
    transferId = json['transfer_id'];
    entityName = json['entity_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_status_id'] = transactionStatusId;
    data['transaction_id'] = transactionId;
    data['transaction_detail_id'] = transactionDetailId;
    data['quantity'] = quantity;
    data['entity_id_to'] = entityIdTo;
    data['entity_type_to'] = entityTypeTo;
    data['customer_id'] = customerId;
    data['sender_account_id'] = senderAccountId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['account_id'] = accountId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['valid_start'] = validStart;
    data['valid_end'] = validEnd;
    data['receiver_account_id'] = receiverAccountId;
    data['category_name'] = categoryName;
    data['material_name'] = materialName;
    data['unit_name'] = unitName;
    data['driver_name'] = driverName;
    data['mou_id'] = mouId;
    data['mou_name'] = mouName;
    data['mou_type'] = mouType;
    data['category_id'] = categoryId;
    data['material_id'] = materialId;
    data['unit_id'] = unitId;
    data['breakage_quantity'] = breakageQuantity;
    data['bin_number'] = binNumber;
    data['expiry_date'] = expiryDate;
    data['transaction_date'] = transactionDate;
    data['entity_id'] = entityId;
    data['entity_type'] = entityType;
    data['client_id'] = clientId;
    data['transaction_type'] = transactionType;
    data['transfer_type'] = transferType;
    data['images'] = images;
    data['notes'] = notes;
    data['transfer_id'] = transferId;
    data['entity_name'] = entityName;
    return data;
  }
}
