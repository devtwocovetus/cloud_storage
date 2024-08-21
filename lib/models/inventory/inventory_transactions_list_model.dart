class InventoryTransactionListModel {
  int? status;
  String? message;
  Pagination? pagination;
  List<Transaction>? data;

  InventoryTransactionListModel(
      {this.status, this.message, this.pagination, this.data});

  InventoryTransactionListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Transaction>[];
      json['data'].forEach((v) {
        data!.add(Transaction.fromJson(v));
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
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? from;
  int? to;
  int? more;

  Pagination(
      {this.total,
      this.perPage,
      this.currentPage,
      this.lastPage,
      this.from,
      this.to,
      this.more});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    from = json['from'];
    to = json['to'];
    more = json['more'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['from'] = from;
    data['to'] = to;
    data['more'] = more;
    return data;
  }
}

class Transaction {
  String? transactionDate;
  int? transactionMasterId;
  int? receivedQuantity;
  int? totalRemainingCount;

  Transaction(
      {this.transactionDate,
      this.transactionMasterId,
      this.receivedQuantity,
      this.totalRemainingCount});

  Transaction.fromJson(Map<String, dynamic> json) {
    transactionDate = json['transaction_date'];
    transactionMasterId = json['transaction_master_id'];
    receivedQuantity = json['received_quantity'];
    totalRemainingCount = json['total_remaining_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_date'] = transactionDate;
    data['transaction_master_id'] = transactionMasterId;
    data['received_quantity'] = receivedQuantity;
    data['total_remaining_count'] = totalRemainingCount;
    return data;
  }
}
