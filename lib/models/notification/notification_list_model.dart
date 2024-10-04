class NotificationListModel {
  int? status;
  String? message;
  List<NotificationModel>? data;

  NotificationListModel({this.status, this.message, this.data});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationModel>[];
      json['data'].forEach((v) {
        data!.add(NotificationModel.fromJson(v));
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

class NotificationModel {
  int? id;
  int? accountId;
  int? userId;
  String? title;
  String? description;
  DataNotification? dataNotification;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  NotificationModel(
      {this.id,
        this.accountId,
        this.userId,
        this.title,
        this.description,
        this.dataNotification,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    dataNotification = json['dataNotification'] != null
        ? DataNotification.fromJson(json['dataNotification'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['account_id'] = accountId;
    data['user_id'] = userId;
    data['title'] = title;
    data['description'] = description;
    if (dataNotification != null) {
      data['dataNotification'] = dataNotification!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class DataNotification {
  String? accountContactNumber;
  String? entityName;
  String? entityType;
  String? clientName;

  DataNotification(
      {this.accountContactNumber,
        this.entityName,
        this.entityType,
        this.clientName});

  DataNotification.fromJson(Map<String, dynamic> json) {
    accountContactNumber = json['accountContactNumber'];
    entityName = json['entityName'];
    entityType = json['entityType'];
    clientName = json['clientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountContactNumber'] = accountContactNumber;
    data['entityName'] = entityName;
    data['entityType'] = entityType;
    data['clientName'] = clientName;
    return data;
  }
}
