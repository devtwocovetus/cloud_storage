class TransactionLogDetailTrOutModel {
  int? status;
  String? message;
  List<ItemTrOut>? data;

  TransactionLogDetailTrOutModel({this.status, this.message, this.data});

  TransactionLogDetailTrOutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ItemTrOut>[];
      json['data'].forEach((v) {
        data!.add(new ItemTrOut.fromJson(v));
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

class ItemTrOut {
  int? id;
  int? materialId;
  String? materialName;
  int? categoryId;
  String? categoryName;
  int? unitId;
  String? unitName;
  int? totalOut;
  String? returnAfterMaterialOut;
  String? returnAfterMaterialIn;
  String? status;

  ItemTrOut(
      {this.id,
      this.materialId,
      this.materialName,
      this.categoryId,
      this.categoryName,
      this.unitId,
      this.unitName,
      this.totalOut,
      this.returnAfterMaterialOut,
      this.returnAfterMaterialIn,
      this.status});

  ItemTrOut.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materialId = json['material_id'];
    materialName = json['material_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    totalOut = json['total_out'];
    returnAfterMaterialOut = json['ReturnAfterMaterialOut'];
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
    data['total_out'] = totalOut;
    data['ReturnAfterMaterialOut'] = returnAfterMaterialOut;
    data['ReturnAfterMaterialIn'] = returnAfterMaterialIn;
    data['status'] = status;
    return data;
  }
}
