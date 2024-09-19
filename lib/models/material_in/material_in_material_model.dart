class MaterialInMaterialModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<MaterialList>? data;

  MaterialInMaterialModel(
      {this.status, this.message, this.pagination, this.data});

  MaterialInMaterialModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <MaterialList>[];
      json['data'].forEach((v) {
        data!.add(MaterialList.fromJson(v));
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

class MaterialList {
  int? id;
  String? skuNumber;
  String? name;
  int? categoryId;
  String? categoryName;
  String? description;
  int? mouId;
  String? mouName;
  String? mouType;
  String? status;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  List<MaterialUnits>? materialUnits;

  MaterialList(
      {this.id,
      this.skuNumber,
      this.name,
      this.categoryId,
      this.categoryName,
      this.description,
      this.mouId,
      this.mouName,
      this.mouType,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.accountId,
      this.createdAt,
      this.updatedAt,
      this.materialUnits});

  MaterialList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skuNumber = json['sku_number'];
    name = json['name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    description = json['description'];
    mouId = json['mou_id'];
    mouName = json['mou_name'];
    mouType = json['mou_type'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['material_units'] != null) {
      materialUnits = <MaterialUnits>[];
      json['material_units'].forEach((v) {
        materialUnits!.add(MaterialUnits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sku_number'] = skuNumber;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['description'] = description;
    data['mou_id'] = mouId;
    data['mou_name'] = mouName;
    data['mou_type'] = mouType;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['account_id'] = accountId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (materialUnits != null) {
      data['material_units'] =
          materialUnits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MaterialUnits {
  int? id;
  int? categoryId;
  int? materialId;
  String? unitName;
  String? quantityType;
  String? measurementOfUnitId;
  int? quantity;
  String? length;
  String? width;
  String? height;
  String? diameter;
  String? weight;
  String? color;
  String? storageConditions;
  String? safetyData;
  String? complianceCertificates;
  String? regulatoryInformation;
  String? status;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? validStart;
  String? validEnd;

  MaterialUnits(
      {this.id,
      this.categoryId,
      this.materialId,
      this.unitName,
      this.quantityType,
      this.measurementOfUnitId,
      this.quantity,
      this.length,
      this.width,
      this.height,
      this.diameter,
      this.weight,
      this.color,
      this.storageConditions,
      this.safetyData,
      this.complianceCertificates,
      this.regulatoryInformation,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.accountId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.validStart,
      this.validEnd});

  MaterialUnits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    materialId = json['material_id'];
    unitName = json['unit_name'];
    quantityType = json['quantity_type'];
    measurementOfUnitId = json['measurement_of_unit_id'];
    quantity = json['quantity'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    diameter = json['diameter'];
    weight = json['weight'];
    color = json['color'];
    storageConditions = json['storage_conditions'];
    safetyData = json['safety_data'];
    complianceCertificates = json['compliance_certificates'];
    regulatoryInformation = json['regulatory_information'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    validStart = json['valid_start'];
    validEnd = json['valid_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['material_id'] = materialId;
    data['unit_name'] = unitName;
    data['quantity_type'] = quantityType;
    data['measurement_of_unit_id'] = measurementOfUnitId;
    data['quantity'] = quantity;
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    data['diameter'] = diameter;
    data['weight'] = weight;
    data['color'] = color;
    data['storage_conditions'] = storageConditions;
    data['safety_data'] = safetyData;
    data['compliance_certificates'] = complianceCertificates;
    data['regulatory_information'] = regulatoryInformation;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['account_id'] = accountId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['valid_start'] = validStart;
    data['valid_end'] = validEnd;
    return data;
  }
}
