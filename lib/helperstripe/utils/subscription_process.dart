import 'dart:convert';
import 'dart:developer';

import 'package:cold_storage_flutter/helperstripe/utils/api_service.dart';
import 'package:cold_storage_flutter/repository/stripe_repository/stripe_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

// +++++++++++++++++++++++++++++++++++
// ++ STRIPE PAYMENT INITIALIZATION ++
// +++++++++++++++++++++++++++++++++++

Future<void> init(String quantity) async {
  Map<String, dynamic> customer = await createCustomer();
  Map<String, dynamic> paymentIntent = await createPaymentIntent(
    customer['id'],
  );

  await createCreditCard(customer['id'], paymentIntent['client_secret']);
  Map<String, dynamic> customerPaymentMethods =
      await getCustomerPaymentMethods(customer['id']);
  Map<String, dynamic> subResponce = await createSubscription(
      customer['id'], customerPaymentMethods['data'][0]['id'], quantity);

  submitPaymentToServer(subResponce);

}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

// +++++++++++++++++++++
// ++ CREATE CUSTOMER ++
// +++++++++++++++++++++

Future<Map<String, dynamic>> createCustomer() async {
  UserPreference userPreference = UserPreference();
  String? userEmail = await userPreference.getUserEmail();
  String? userName = await userPreference.getUserName();
  final customerCreationResponse = await apiService(
    endpoint: 'customers',
    requestMethod: ApiServiceMethodType.post,
    requestBody: {
      'name': userName,
      'email': userEmail,
      'description': 'cold storage created',
    },
  );
  print('<><>res $customerCreationResponse');
  return customerCreationResponse!;
}

// ++++++++++++++++++++++++++
// ++ SETUP PAYMENT INTENT ++
// ++++++++++++++++++++++++++

Future<Map<String, dynamic>> createPaymentIntent(String customerId) async {
  final paymentIntentCreationResponse = await apiService(
    requestMethod: ApiServiceMethodType.post,
    endpoint: 'setup_intents',
    requestBody: {
      'customer': customerId,
      'automatic_payment_methods[enabled]': 'true',
    },
  );

  return paymentIntentCreationResponse!;
}

// ++++++++++++++++++++++++
// ++ CREATE CREDIT CARD ++
// ++++++++++++++++++++++++

Future<void> createCreditCard(
  String customerId,
  String paymentIntentClientSecret,
) async {
  await Stripe.instance.initPaymentSheet(
    paymentSheetParameters: SetupPaymentSheetParameters(
      primaryButtonLabel: 'Subscribe',
      style: ThemeMode.light,
      merchantDisplayName: 'Flutter Stripe Store Demo',
      customerId: customerId,
      setupIntentClientSecret: paymentIntentClientSecret,
    ),
  );

  await Stripe.instance.presentPaymentSheet();
}

Future<void> confirmPayment(
  String paymentIntentClientSecret,
) async {
  await Stripe.instance
      .confirmPayment(paymentIntentClientSecret: paymentIntentClientSecret);
}

// +++++++++++++++++++++++++++++++++
// ++ GET CUSTOMER PAYMENT METHOD ++
// +++++++++++++++++++++++++++++++++

Future<Map<String, dynamic>> getCustomerPaymentMethods(
  String customerId,
) async {
  final customerPaymentMethodsResponse = await apiService(
    endpoint: 'customers/$customerId/payment_methods',
    requestMethod: ApiServiceMethodType.get,
  );

  return customerPaymentMethodsResponse!;
}

// +++++++++++++++++++++++++
// ++ CREATE SUBSCRIPTION ++
// +++++++++++++++++++++++++

Future<Map<String, dynamic>> createSubscription(
    String customerId, String paymentId, String quantity) async {
  final subscriptionCreationResponse = await apiService(
    endpoint: 'subscriptions',
    requestMethod: ApiServiceMethodType.post,
    requestBody: {
      'customer': customerId,
      'items[0][price]': 'price_1PJbs6SDIgmh0msCnsVQ2MaK',
      'items[0][quantity]': quantity,
      'default_payment_method': paymentId,
      'payment_behavior': 'allow_incomplete',
    },
  );
  print('<><>sub $subscriptionCreationResponse');
  return subscriptionCreationResponse!;
}

void submitPaymentToServer(Map<String, dynamic> subResponce){
  final _api = StripeRepository();
    EasyLoading.show(status: 'loading...');
    Map data = {
      'subscription_id': subResponce['id'],
      'customer_id': subResponce['customer'],
      'plan_id': 'price_1PJbs6SDIgmh0msCnsVQ2MaK',
      'user_count': subResponce['quantity'],
      'current_period_start': subResponce['current_period_start'],
      'current_period_end': subResponce['current_period_end'],
      'status': 'active',
      'payment_response': subResponce.toString()
    };
    _api.submitPaymentApi(data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.snackBar('Error', value['message']);
      } else {
        Utils.snackBar('Subscription', 'Subscribe successfully');
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
}
