class AutoMappingModel {
  int? status;
  String? message;
  Data? data;

  AutoMappingModel({this.status, this.message, this.data});

  AutoMappingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? accountId;
  int? categoryId;
  String? categoryName;
  int? materialId;
  String? materialName;
  int? unitId;
  String? unitName;

  Data(
      {this.accountId,
      this.categoryId,
      this.categoryName,
      this.materialId,
      this.materialName,
      this.unitId,
      this.unitName});

  Data.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    materialId = json['material_id'];
    materialName = json['material_name'];
    unitId = json['unit_id'];
    unitName = json['unit_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_id'] = this.accountId;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['material_id'] = this.materialId;
    data['material_name'] = this.materialName;
    data['unit_id'] = this.unitId;
    data['unit_name'] = this.unitName;
    return data;
  }
}
