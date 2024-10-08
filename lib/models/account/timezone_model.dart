class TimeZoneModel {
  int? status;
  String? message;
  List<Data>? data;

  TimeZoneModel({this.status, this.message, this.data});

  TimeZoneModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  String? name;
  String? abbreviation;
  String? utcOffset;
  String? description;
  int? isDst;
  String? gmtOffset;
  String? countryCode;
  String? status;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? validFrom;
  String? validTo;

  Data(
      {this.id,
      this.name,
      this.abbreviation,
      this.utcOffset,
      this.description,
      this.isDst,
      this.gmtOffset,
      this.countryCode,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.validFrom,
      this.validTo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    abbreviation = json['abbreviation'];
    utcOffset = json['utc_offset'];
    description = json['description'];
    isDst = json['is_dst'];
    gmtOffset = json['gmt_offset'];
    countryCode = json['country_code'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['abbreviation'] = abbreviation;
    data['utc_offset'] = utcOffset;
    data['description'] = description;
    data['is_dst'] = isDst;
    data['gmt_offset'] = gmtOffset;
    data['country_code'] = countryCode;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    return data;
  }
}