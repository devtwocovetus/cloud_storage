class TransactionLogListModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<TransactionLogItem>? data;

  TransactionLogListModel(
      {this.status, this.message, this.pagination, this.data});

  TransactionLogListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <TransactionLogItem>[];
      json['data'].forEach((v) {
        data!.add(TransactionLogItem.fromJson(v));
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

class TransactionLogItem {
  int? id;
  String? clientId;
  String? transactionDate;
  String? transactionType;
  String? transactionUniqueCode;
  String? vendorClientName;
  String? senderAccount;
  String? customerClientName;

  TransactionLogItem(
      {this.id,
      this.clientId,
      this.transactionDate,
      this.transactionType,
      this.transactionUniqueCode,
      this.vendorClientName,
      this.senderAccount,
      this.customerClientName});

  TransactionLogItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    transactionDate = json['transaction_date'];
    transactionType = json['transaction_type'];
    transactionUniqueCode = json['transaction_unique_code'];
    vendorClientName = json['vendor_client_name'];
    senderAccount = json['sender_account'];
    customerClientName = json['customer_client_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['transaction_date'] = transactionDate;
    data['transaction_type'] = transactionType;
    data['transaction_unique_code'] = transactionUniqueCode;
    data['vendor_client_name'] = vendorClientName;
    data['sender_account'] = senderAccount;
    data['customer_client_name'] = customerClientName;
    return data;
  }
}
