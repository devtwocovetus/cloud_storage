class InventoryTransactionsDetailListModel {
  int? status;
  String? message;
  Quantity? data;

  InventoryTransactionsDetailListModel({this.status, this.message, this.data});

  InventoryTransactionsDetailListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Quantity.fromJson(json['data']) : null;
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

class Quantity {
  List<TransactionMaster>? transactionMaster;
  List<TransactionDetail>? transactionDetail;

  Quantity({this.transactionMaster, this.transactionDetail});

  Quantity.fromJson(Map<String, dynamic> json) {
    if (json['transactionMaster'] != null) {
      transactionMaster = <TransactionMaster>[];
      json['transactionMaster'].forEach((v) {
        transactionMaster!.add(TransactionMaster.fromJson(v));
      });
    }
    if (json['transactionDetail'] != null) {
      transactionDetail = <TransactionDetail>[];
      json['transactionDetail'].forEach((v) {
        transactionDetail!.add(TransactionDetail.fromJson(v));
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

class TransactionMaster {
  int? id;
  String? transactionDate;
  String? transactionType;
  String? clientId;
  String? clientName;

  TransactionMaster(
      {this.id,
      this.transactionDate,
      this.transactionType,
      this.clientId,
      this.clientName});

  TransactionMaster.fromJson(Map<String, dynamic> json) {
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

class TransactionDetail {
  int? id;
  int? materialId;
  String? materialName;
  int? categoryId;
  String? categoryName;
  int? unitId;
  String? unitName;
  int? unitQuantity;
  int? totalReceived;
  int? breakageQuantity;
  String? oUT;
  String? intransit;
  String? totalRemainingCount;
  String? expiryDate;
  String? binNumber;
  String? binName;
  int? quantityTypeId;
  String? quantityTypeName;
  int? mouId;
  String? mouName;
  String? mouType;
  String? images;
  bool? materialEditable;

  TransactionDetail(
      {this.id,
      this.materialId,
      this.materialName,
      this.categoryId,
      this.categoryName,
      this.unitId,
      this.unitName,
      this.unitQuantity,
      this.totalReceived,
      this.breakageQuantity,
      this.oUT,
      this.intransit,
      this.totalRemainingCount,
      this.expiryDate,
      this.binNumber,
      this.binName,
      this.quantityTypeId,
      this.quantityTypeName,
      this.mouId,
      this.mouName,
      this.mouType,
      this.images,
      this.materialEditable});

  TransactionDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materialId = json['material_id'];
    materialName = json['material_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    unitQuantity = json['unit_quantity'];
    totalReceived = json['total_received'];
    breakageQuantity = json['breakage_quantity'];
    oUT = json['OUT'];
    intransit = json['Intransit'];
    totalRemainingCount = json['total_remaining_count'];
    expiryDate = json['expiry_date'];
    binNumber = json['bin_number'];
    binName = json['bin_name'];
    quantityTypeId = json['quantity_type_id'];
    quantityTypeName = json['quantity_type_name'];
    mouId = json['mou_id'];
    mouName = json['mou_name'];
    mouType = json['mou_type'];
    images = json['images'];
    materialEditable = json['materialEditable'];
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
    data['unit_quantity'] = unitQuantity;
    data['total_received'] = totalReceived;
    data['breakage_quantity'] = breakageQuantity;
    data['OUT'] = oUT;
    data['Intransit'] = intransit;
    data['total_remaining_count'] = totalRemainingCount;
    data['expiry_date'] = expiryDate;
    data['bin_number'] = binNumber;
    data['bin_name'] = binName;
    data['quantity_type_id'] = quantityTypeId;
    data['quantity_type_name'] = quantityTypeName;
    data['mou_id'] = mouId;
    data['mou_name'] = mouName;
    data['mou_type'] = mouType;
    data['images'] = images;
    data['materialEditable'] = materialEditable;
    return data;
  }
}
