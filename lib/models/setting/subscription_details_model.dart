class SubscriptionDetailsModel {
  int? status;
  String? message;
  Data? data;

  SubscriptionDetailsModel({this.status, this.message, this.data});

  SubscriptionDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? id;
  int? userId;
  String? subscriptionId;
  String? stripeCustomerId;
  String? planId;
  int? userCount;
  String? startDate;
  String? endDate;
  String? userSubscriptionStatus;
  String? paymentIntentId;
  String? clientSecret;
  int? createdBy;
  String? updatedBy;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  String? amount;

  Data(
      {this.id,
      this.userId,
      this.subscriptionId,
      this.stripeCustomerId,
      this.planId,
      this.userCount,
      this.startDate,
      this.endDate,
      this.userSubscriptionStatus,
      this.paymentIntentId,
      this.clientSecret,
      this.createdBy,
      this.updatedBy,
      this.accountId,
      this.createdAt,
      this.updatedAt,
      this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    subscriptionId = json['subscription_id'];
    stripeCustomerId = json['stripe_customer_id'];
    planId = json['plan_id'];
    userCount = json['user_count'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    userSubscriptionStatus = json['user_subscription_status'];
    paymentIntentId = json['paymentIntent_id'];
    clientSecret = json['clientSecret'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['subscription_id'] = subscriptionId;
    data['stripe_customer_id'] = stripeCustomerId;
    data['plan_id'] = planId;
    data['user_count'] = userCount;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['user_subscription_status'] = userSubscriptionStatus;
    data['paymentIntent_id'] = paymentIntentId;
    data['clientSecret'] = clientSecret;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['account_id'] = accountId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['amount'] = amount;
    return data;
  }
}
