class EntityAssignedListModel {
  int? status;
  String? message;
  List<EntityAssigned>? data;

  EntityAssignedListModel({this.status, this.message, this.data});

  EntityAssignedListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <EntityAssigned>[];
      json['data'].forEach((v) {
        data!.add(EntityAssigned.fromJson(v));
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

class EntityAssigned {
  int? entityId;
  int? entityType;
  String? entityTypeName;
  String? name;
  bool? assigned;
  String? profileImage;

  EntityAssigned(
      {this.entityId,
      this.entityType,
      this.entityTypeName,
      this.name,
      this.assigned,
      this.profileImage});

  EntityAssigned.fromJson(Map<String, dynamic> json) {
    entityId = json['entity_id'];
    entityType = json['entity_type'];
    entityTypeName = json['entity_type_name'];
    name = json['name'];
    assigned = json['assigned'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['entity_id'] = entityId;
    data['entity_type'] = entityType;
    data['entity_type_name'] = entityTypeName;
    data['name'] = name;
    data['assigned'] = assigned;
    data['profile_image'] = profileImage;
    return data;
  }
}
