class ClientInventoryTransactionsDetail {
  int? status;
  String? message;
  ClientQuantity? data;

  ClientInventoryTransactionsDetail({this.status, this.message, this.data});

  ClientInventoryTransactionsDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ClientQuantity.fromJson(json['data']) : null;
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

class ClientQuantity {
  List<ClientTransactionMaster>? transactionMaster;
  List<ClientTransactionDetail>? transactionDetail;

  ClientQuantity({this.transactionMaster, this.transactionDetail});

  ClientQuantity.fromJson(Map<String, dynamic> json) {
    if (json['transactionMaster'] != null) {
      transactionMaster = <ClientTransactionMaster>[];
      json['transactionMaster'].forEach((v) {
        transactionMaster!.add(ClientTransactionMaster.fromJson(v));
      });
    }
    if (json['transactionDetail'] != null) {
      transactionDetail = <ClientTransactionDetail>[];
      json['transactionDetail'].forEach((v) {
        transactionDetail!.add(ClientTransactionDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transactionMaster != null) {
      data['transactionMaster'] =
          transactionMaster!.map((v) => v.toJson()).toList();
    }
    if (transactionDetail != null) {
      data['transactionDetail'] =
          transactionDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientTransactionMaster {
  int? id;
  String? transactionDate;
  String? transactionType;
  String? clientId;
  String? clientName;

  ClientTransactionMaster(
      {this.id,
      this.transactionDate,
      this.transactionType,
      this.clientId,
      this.clientName});

  ClientTransactionMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionDate = json['transaction_date'];
    transactionType = json['transaction_type'];
    clientId = json['client_id'];
    clientName = json['client_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_date'] = transactionDate;
    data['transaction_type'] = transactionType;
    data['client_id'] = clientId;
    data['client_name'] = clientName;
    return data;
  }
}

class ClientTransactionDetail {
  int? id;
  int? materialId;
  String? materialName;
  int? categoryId;
  String? categoryName;
  int? unitId;
  String? unitName;
  int? totalReceived;
  int? breakageQuantity;
  String? oUT;
  String? intransit;
  String? totalRemainingCount;
  String? expiryDate;
  String? binName;
  String? quantityTypeName;
  String? images;

  ClientTransactionDetail(
      {this.id,
      this.materialId,
      this.materialName,
      this.categoryId,
      this.categoryName,
      this.unitId,
      this.unitName,
      this.totalReceived,
      this.breakageQuantity,
      this.oUT,
      this.intransit,
      this.totalRemainingCount,
      this.expiryDate,
      this.binName,
      this.quantityTypeName,
      this.images});

  ClientTransactionDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materialId = json['material_id'];
    materialName = json['material_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    totalReceived = json['total_received'];
    breakageQuantity = json['breakage_quantity'];
    oUT = json['OUT'];
    intransit = json['Intransit'];
    totalRemainingCount = json['total_remaining_count'];
    expiryDate = json['expiry_date'];
    binName = json['bin_name'] ?? '';
    quantityTypeName = json['quantity_type_name'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['material_id'] = materialId;
    data['material_name'] = materialName;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['unit_id'] = unitId;
    data['unit_name'] = unitName;
    data['total_received'] = totalReceived;
    data['breakage_quantity'] = breakageQuantity;
    data['OUT'] = oUT;
    data['Intransit'] = intransit;
    data['total_remaining_count'] = totalRemainingCount;
    data['expiry_date'] = expiryDate;
    data['bin_name'] = binName;
    data['quantity_type_name'] = quantityTypeName;
    data['images'] = images;
    return data;
  }
}
