import 'package:cold_storage_flutter/helperstripe/utils/api_service.dart';
import 'package:cold_storage_flutter/repository/stripe_repository/stripe_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

// +++++++++++++++++++++++++++++++++++
// ++ STRIPE PAYMENT INITIALIZATION ++
// +++++++++++++++++++++++++++++++++++

class SubscriptionViewModel extends GetxController {
  final _api = StripeRepository();
  dynamic userData = <String, dynamic>{};

  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }

  Future<void> takeSubscription(String quantity, String amount) async {
    Map<String, dynamic> customer = await createCustomer();
    Map<String, dynamic> subResponce =
        await createSubscription(customer['id'], quantity);
    await createCreditCard(customer['id'],
        subResponce['latest_invoice']['payment_intent']['client_secret']);
     submitPaymentToServer(subResponce, amount);
  }

  Future<Map<String, dynamic>> createCustomer() async {
    EasyLoading.show(status: 'loading...');
    final customerCreationResponse = await apiService(
      endpoint: 'customers',
      requestMethod: ApiServiceMethodType.post,
      requestBody: {
        'name': userData['data']['accoutDetails']['name'],
        'email': userData['data']['accoutDetails']['email'],
        'address[line1]': '29',
        'address[line2]': 'Sarojni Nagar',
        'address[postal_code]': '450001',
        'address[city]': 'Khandwa',
        'address[state]': 'Madhya Pradesh',
        'address[country]': 'India',
        'description': 'cold storage user',
      },
    );
    EasyLoading.dismiss();
    return customerCreationResponse!;
  }

  Future<void> getUserDetails() async {
    EasyLoading.show(status: 'loading...');
    _api.getUserData().then((value) async {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        print('<><><> $value');
        userData = value;
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future<void> createCreditCard(
    String customerId,
    String paymentIntentClientSecret,
  ) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        customFlow: true,
        primaryButtonLabel: 'Subscribe',
        style: ThemeMode.light,
        merchantDisplayName: 'AgTech',
        customerId: customerId,
        paymentIntentClientSecret: paymentIntentClientSecret,
        allowsDelayedPaymentMethods: true,
        billingDetails: BillingDetails(
            email: userData['data']['accoutDetails']['email'],
            address: const Address(
                city: 'Khandwa',
                country: 'India',
                line1: '29',
                line2: 'Sarojni Nagar',
                postalCode: '450001',
                state: 'Madhya Pradesh'),
            phone: userData['data']['accoutDetails']['contact_number'],
            name: userData['data']['accoutDetails']['name']),
      ),
    );
    await Stripe.instance.presentPaymentSheet();
    await Stripe.instance.confirmPaymentSheetPayment();
  }

  Future<Map<String, dynamic>> createSubscription(
      String customerId, String quantity) async {
    int a = int.parse(quantity) + 1;
    quantity = a.toString();
    final subscriptionCreationResponse = await apiService(
      endpoint: 'subscriptions',
      requestMethod: ApiServiceMethodType.post,
      requestBody: {
        'customer': customerId,
        'items[0][price]': 'price_1PvgH8SDIgmh0msCsbeFobnO',
        'items[0][quantity]': "1",
        'items[1][price]': 'price_1PvgI0SDIgmh0msCFu9TcKAu',
        'items[1][quantity]': quantity,
        'payment_settings[save_default_payment_method]': 'on_subscription',
        'expand[0]': 'latest_invoice.payment_intent',
        'payment_behavior': 'default_incomplete',
      },
    );
    return subscriptionCreationResponse!;
  }

  Future<void> submitPaymentToServer(
      Map<String, dynamic> subResponce, String amount) async {
    UserPreference userPreference = UserPreference();
    EasyLoading.show(status: 'loading...');
    Map data = {
      'subscription_id': subResponce['id'],
      'customer_id': subResponce['customer'],
      'base_plan[subscription_plan_id]': subResponce['items']['data'][0]['plan']['id'],
      'base_plan[subscription_item_id]': subResponce['items']['data'][0]['id'],
      'base_plan[quantity]': subResponce['items']['data'][0]['quantity'].toString(),
      'user_plan[subscription_plan_id]':subResponce['items']['data'][1]['plan']['id'],
      'user_plan[subscription_item_id]': subResponce['items']['data'][1]['id'],
      'user_plan[quantity]': subResponce['items']['data'][1]['quantity'].toString(),
      'current_period_start': subResponce['current_period_start'].toString(),
      'current_period_end': subResponce['current_period_end'].toString(),
      'status': 'active',
      'amount': amount.toString(),
    };
    //printWrapped('<><>### ${data.toString()}');
    _api.submitPaymentApi(data).then((value) {
      print('<><>@@## ${value.toString()}');
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.isCheck = true;
        Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Subscription', 'Subscribe successfully');
        userPreference.updateCurrentAccountStatus(3);
        Get.offAllNamed(RouteName.userListView)!.then((value) {});
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.isCheck = true;
      Utils.snackBar('Error', error.toString());
    });
  }
}
