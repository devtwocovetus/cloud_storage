class AssetDetails {
  int? status;
  String? message;
  Asset? data;

  AssetDetails({this.status, this.message, this.data});

  AssetDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Asset.fromJson(json['data']) : null;
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

class Asset {
  int? id;
  String? assetName;
  int? category;
  String? location;
  int? entityType;
  String? description;
  String? make;
  String? model;
  String? serialNumber;
  String? purchaseDate;
  String? purchasePrice;
  String? vendorName;
  String? vendorContactNumber;
  String? vendorEmail;
  String? invoiceNumber;
  String? warrantyDetails;
  String? operationalStatus;
  String? condition;
  String? lastUpdated;
  String? comments;
  String? insuranceProvider;
  String? insurancePolicyNumber;
  String? insuranceExpiryDate;
  String? status;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? validFrom;
  String? validTo;

  Asset(
      {this.id,
        this.assetName,
        this.category,
        this.location,
        this.entityType,
        this.description,
        this.make,
        this.model,
        this.serialNumber,
        this.purchaseDate,
        this.purchasePrice,
        this.vendorName,
        this.vendorContactNumber,
        this.vendorEmail,
        this.invoiceNumber,
        this.warrantyDetails,
        this.operationalStatus,
        this.condition,
        this.lastUpdated,
        this.comments,
        this.insuranceProvider,
        this.insurancePolicyNumber,
        this.insuranceExpiryDate,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.accountId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.validFrom,
        this.validTo});

  Asset.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assetName = json['asset_name'];
    category = json['category'];
    location = json['location'];
    entityType = json['entity_type'];
    description = json['description'];
    make = json['make'];
    model = json['model'];
    serialNumber = json['serial_number'];
    purchaseDate = json['purchase_date'];
    purchasePrice = json['purchase_price'];
    vendorName = json['vendor_name'];
    vendorContactNumber = json['vendor_contact_number'];
    vendorEmail = json['vendor_email'];
    invoiceNumber = json['invoice_number'];
    warrantyDetails = json['warranty_details'];
    operationalStatus = json['operational_status'];
    condition = json['condition'];
    lastUpdated = json['last_updated'];
    comments = json['comments'];
    insuranceProvider = json['insurance_provider'];
    insurancePolicyNumber = json['insurance_policy_number'];
    insuranceExpiryDate = json['insurance_expiry_date'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['asset_name'] = assetName;
    data['category'] = category;
    data['location'] = location;
    data['entity_type'] = entityType;
    data['description'] = description;
    data['make'] = make;
    data['model'] = model;
    data['serial_number'] = serialNumber;
    data['purchase_date'] = purchaseDate;
    data['purchase_price'] = purchasePrice;
    data['vendor_name'] = vendorName;
    data['vendor_contact_number'] = vendorContactNumber;
    data['vendor_email'] = vendorEmail;
    data['invoice_number'] = invoiceNumber;
    data['warranty_details'] = warrantyDetails;
    data['operational_status'] = operationalStatus;
    data['condition'] = condition;
    data['last_updated'] = lastUpdated;
    data['comments'] = comments;
    data['insurance_provider'] = insuranceProvider;
    data['insurance_policy_number'] = insurancePolicyNumber;
    data['insurance_expiry_date'] = insuranceExpiryDate;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['account_id'] = accountId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    return data;
  }
}
