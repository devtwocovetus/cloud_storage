class TransactionLogDetailInModel {
  int? status;
  String? message;
  List<TransactionDetailItemIn>? data;

  TransactionLogDetailInModel({this.status, this.message, this.data});

  TransactionLogDetailInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TransactionDetailItemIn>[];
      json['data'].forEach((v) {
        data!.add(TransactionDetailItemIn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionDetailItemIn {
  int? id;
  int? materialId;
  String? materialName;
  int? categoryId;
  String? categoryName;
  int? unitId;
  String? unitName;
  int? breakageQuantity;
  int? totalReceived;
  String? adjustPlus;
  String? returnAfterMaterialOut;
  String? totalOut;
  String? intransit;
  String? totalRemainingCount;
  String? tRANSFERIN;
  String? tRANSFEROUT;
  String? adjustMinus;
  String? returnAfterMaterialIn;
  String? status;

  TransactionDetailItemIn(
      {this.id,
      this.materialId,
      this.materialName,
      this.categoryId,
      this.categoryName,
      this.unitId,
      this.unitName,
      this.breakageQuantity,
      this.totalReceived,
      this.adjustPlus,
      this.returnAfterMaterialOut,
      this.totalOut,
      this.intransit,
      this.totalRemainingCount,
      this.tRANSFERIN,
      this.tRANSFEROUT,
      this.adjustMinus,
      this.returnAfterMaterialIn,
      this.status});

  TransactionDetailItemIn.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materialId = json['material_id'];
    materialName = json['material_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    breakageQuantity = json['breakage_quantity'];
    totalReceived = json['total_received'];
    adjustPlus = json['adjustPlus'];
    returnAfterMaterialOut = json['ReturnAfterMaterialOut'];
    totalOut = json['total_out'];
    intransit = json['intransit'];
    totalRemainingCount = json['total_remaining_count'];
    tRANSFERIN = json['TRANSFERIN'];
    tRANSFEROUT = json['TRANSFEROUT'];
    adjustMinus = json['adjustMinus'];
    returnAfterMaterialIn = json['ReturnAfterMaterialIn'];
    status = json['status'];
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
    data['breakage_quantity'] = breakageQuantity;
    data['total_received'] = totalReceived;
    data['adjustPlus'] = adjustPlus;
    data['ReturnAfterMaterialOut'] = returnAfterMaterialOut;
    data['total_out'] = totalOut;
    data['intransit'] = intransit;
    data['total_remaining_count'] = totalRemainingCount;
    data['TRANSFERIN'] = tRANSFERIN;
    data['TRANSFEROUT'] = tRANSFEROUT;
    data['adjustMinus'] = adjustMinus;
    data['ReturnAfterMaterialIn'] = returnAfterMaterialIn;
    data['status'] = status;
    return data;
  }
}
