import 'package:cold_storage_flutter/helperstripe/utils/api_service.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';
import 'package:cold_storage_flutter/models/client/client_list_model.dart';
import 'package:cold_storage_flutter/repository/stripe_repository/stripe_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class SettingSubscriptionViewModel extends GetxController {
  final _api = StripeRepository();

  RxList<Client>? clientList = <Client>[].obs;
  var isLoading = true.obs;

  RxString mStrSubscriptionId = ''.obs;
  RxString mStrCustomerId = ''.obs;

  RxString mStrBasePlanSubPlanId = ''.obs;
  RxString mStrBasePlanSubItemId = ''.obs;
  RxInt mStrBasePlanSubQuantity = 0.obs;

  RxString mStrUserPlanSubPlanId = ''.obs;
  RxString mStrUserPlanSubItemId = ''.obs;
  RxInt mStrUserPlanSubQuantity = 0.obs;

  RxString mStrUserName = ''.obs;
  RxString mStrUserEmail = ''.obs;
  RxString mStrUserPhone = ''.obs;

  RxString mStrPlanId = ''.obs;
  RxInt mIntUserCount = 0.obs;
  RxInt mIntUserId = 0.obs;
  RxInt mIntAccountId = 0.obs;
  RxInt mFinalUserCount = 0.obs;

  RxInt totalValue = 299.obs;
  RxInt userValue = 0.obs;
  RxInt totalValueOld = 299.obs;
  RxInt userValueOld = 0.obs;
  RxInt currentUser = 0.obs;
  RxBool isIncrees = false.obs;
  final myController = TextEditingController(text: '0').obs;

  @override
  void onInit() {
    getSubscriptionDetails();
    super.onInit();
  }

  void updateUserCount(String op) {
    if (op == '+') {
      currentUser.value = currentUser.value + 1;
    } else {
      if (currentUser.value != 0) {
        currentUser.value = currentUser.value - 1;
      }
    }
    if (mIntUserCount.value > currentUser.value) {
      isIncrees.value = false;
      mFinalUserCount.value = mIntUserCount.value - currentUser.value;
    } else if (mIntUserCount.value < currentUser.value) {
      isIncrees.value = true;
      mFinalUserCount.value = currentUser.value - mIntUserCount.value;
    } else {
      isIncrees.value = false;
      mFinalUserCount.value = currentUser.value;
    }
  }

  void getSubscriptionDetails() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.getUserData().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        mStrSubscriptionId.value =
            value['data']['subscriptionModel']['subscription_id'];
        mStrCustomerId.value =
            value['data']['subscriptionModel']['customer_id'];

        mStrBasePlanSubPlanId.value = value['data']['subscriptionModel']
            ['base_plan']['subscription_plan_id'];
        mStrBasePlanSubItemId.value = value['data']['subscriptionModel']
            ['base_plan']['subscription_item_id'];
        mStrBasePlanSubQuantity.value =
            value['data']['subscriptionModel']['base_plan']['quantity'];

        mStrUserPlanSubPlanId.value = value['data']['subscriptionModel']
            ['user_plan']['subscription_plan_id'];
        mStrUserPlanSubItemId.value = value['data']['subscriptionModel']
            ['user_plan']['subscription_item_id'];
        mStrUserPlanSubQuantity.value =
            value['data']['subscriptionModel']['user_plan']['quantity'];

        mStrUserPhone.value = value['data']['accoutDetails']['contact_number'];
        mStrUserName.value = value['data']['accoutDetails']['name'];
        mStrUserEmail.value = value['data']['accoutDetails']['email'];

        if (mStrUserPlanSubQuantity.value == 1) {
          currentUser.value = mStrUserPlanSubQuantity.value - 1;
          totalValue.value = 299;
          userValue.value = 0;
          totalValueOld.value = 200 + mStrUserPlanSubQuantity.value * 99;
          userValueOld.value = currentUser.value * 99;
          myController.value.text = currentUser.value.toString();
          mIntUserCount.value = currentUser.value;
        } else {
          totalValue.value = 200 + mStrUserPlanSubQuantity.value * 99;
          currentUser.value = mStrUserPlanSubQuantity.value - 1;
          userValue.value = currentUser.value * 99;
          totalValueOld.value = 200 + mStrUserPlanSubQuantity.value * 99;
          userValueOld.value = currentUser.value * 99;
          myController.value.text = currentUser.value.toString();
          mIntUserCount.value = currentUser.value;
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future<Map<String, dynamic>> getCustomerPaymentMethods(
    String customerId,
  ) async {
    EasyLoading.show(status: t.loading);
    final customerPaymentMethodsResponse = await apiService(
      endpoint: 'customers/$customerId/payment_methods',
      requestMethod: ApiServiceMethodType.get,
    );
    print('<><> ${customerPaymentMethodsResponse.toString()}');
    EasyLoading.dismiss();
    return customerPaymentMethodsResponse!;
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String customerId, String paymentMethodeId, int amount) async {
    int a = amount * 100;
    EasyLoading.show(status: t.loading);
    final paymentIntentCreationResponse = await apiService(
      requestMethod: ApiServiceMethodType.post,
      endpoint: 'payment_intents',
      requestBody: {
        'customer': customerId,
        'amount': a.toString(),
        'currency': 'usd',
        'payment_method': paymentMethodeId, //pm_1PvGAASDIgmh0msCUOGUuKx0
        'description': 'cold storage created',
      },
    );
    //printWrapped('<><>res333 ${paymentIntentCreationResponse.toString()}');
    //print('<><>res333 ${paymentIntentCreationResponse.toString()}');

    EasyLoading.dismiss();
    print('<><> ${paymentIntentCreationResponse.toString()}');
    return paymentIntentCreationResponse!;
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
            email: mStrUserEmail.value.toString(),
            address: const Address(
                city: 'Khandwa',
                country: 'India',
                line1: '29',
                line2: 'sarojni nagar',
                postalCode: '450001',
                state: 'Madhya Pradesh'),
            phone: mStrUserPhone.value.toString(),
            name: mStrUserName.value.toString()),
      ),
    );
    await Stripe.instance.presentPaymentSheet();
    await Stripe.instance.confirmPaymentSheetPayment();
  }

  Future<Map<String, dynamic>> createSubscription(
      String subscriptionsId, String subscriptionsItemId, int quantity) async {
    EasyLoading.show(status: t.loading);
    final subscriptionCreationResponse = await apiService(
      endpoint: 'subscriptions/$subscriptionsId',
      requestMethod: ApiServiceMethodType.post,
      requestBody: {
        'items[0][id]': mStrBasePlanSubItemId.value,
        'items[0][quantity]': '1',
        'items[1][id]': mStrUserPlanSubItemId.value,
        'items[1][quantity]': quantity.toString(),
      },
    );
    EasyLoading.dismiss();
    return subscriptionCreationResponse!;
  }

  void proceedToPay(int quantity, int amount) async {
    Map<String, dynamic> customerPaymentMethods =
        await getCustomerPaymentMethods(mStrCustomerId.value);
    Map<String, dynamic> paymentIntent = await createPaymentIntent(
        mStrCustomerId.value, customerPaymentMethods['data'][0]['id'], amount);

    await createCreditCard(
        mStrCustomerId.value, paymentIntent['client_secret']);

    Map<String, dynamic> subResponce = await createSubscription(
        mStrSubscriptionId.value, mStrUserPlanSubItemId.value, quantity);

    submitPaymentToServer(
        mStrSubscriptionId.value, mStrUserPlanSubItemId.value, quantity);

    print('<><><>@@##### ${subResponce.values}');
  }

  Future<void> submitPaymentToServer(
      String subscriptionsId, String subscriptionsItemId, int quantity) async {
    EasyLoading.show(status: t.loading);
    Map data = {
      'subscription_id': subscriptionsId,
      'subscription_user_item_id': subscriptionsItemId,
      'quantity': quantity.toString(),
      'payment_status': "1"
    };
    //printWrapped('<><>### ${data.toString()}');
    _api.updatePaymentApi(data).then((value) {
      print('<><>@@## ${value.toString()}');
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.isCheck = true;
        Utils.snackBar(t.error_text, value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar(t.subscription, t.subscribe_updated_success_text);
        Get.until((route) => Get.currentRoute == RouteName.settingDashboard);
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.isCheck = true;
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void proceedOnly(int quantity) async {
    Map<String, dynamic> subResponce = await createSubscription(
        mStrSubscriptionId.value, mStrUserPlanSubItemId.value, quantity);
  }
}
