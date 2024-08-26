import 'package:cold_storage_flutter/models/client/client_list_model.dart';
import 'package:cold_storage_flutter/repository/stripe_repository/stripe_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SettingSubscriptionViewModel extends GetxController {
  final _api = StripeRepository();

  RxList<Client>? clientList = <Client>[].obs;
  RxString logoUrl = ''.obs;
  var isLoading = true.obs;
  RxString mStrSubscriptionId = ''.obs;
  RxString mStrStripeCustomerId = ''.obs;
  RxString mStrPlanId = ''.obs;
  RxInt mIntUserCount = 0.obs;
  RxInt mIntUserId = 0.obs;
  RxInt mIntAccountId = 0.obs;
  RxInt mFinalUserCount = 0.obs;

  RxInt totalValue = 10.obs;
  RxInt userValue = 0.obs;
  RxInt totalValueOld = 10.obs;
  RxInt userValueOld = 0.obs;
  RxBool isIncrees = false.obs;
  final myController = TextEditingController(text: '0').obs;

  @override
  void onInit() {
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getSubscriptionDetails();
    super.onInit();
  }

  void updateUserCount() {
    if (mIntUserCount.value > int.parse(myController.value.text)) {
      isIncrees.value = false;
      mFinalUserCount.value =
          mIntUserCount.value - int.parse(myController.value.text);
    } else if (mIntUserCount.value < int.parse(myController.value.text)) {
      isIncrees.value = true;
      mFinalUserCount.value =
          int.parse(myController.value.text) - mIntUserCount.value;
    }
  }

  void getSubscriptionDetails() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.getSubscriptionDetail().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        mStrSubscriptionId.value = value['data']['subscription_id'].toString();
        mStrStripeCustomerId.value =
            value['data']['stripe_customer_id'].toString();
        mStrPlanId.value = value['data']['plan_id'].toString();
        mIntUserCount.value = value['data']['user_count'];
        mIntUserId.value = value['data']['user_id'];
        mIntAccountId.value = value['data']['account_id'];
        myController.value.text = mIntUserCount.value.toString();

        if (myController.value.text.isEmpty) {
          totalValue.value = 10;
          userValue.value = 0;
        } else {
          totalValue.value = 10 + int.parse(myController.value.text) * 5;
          userValue.value = int.parse(myController.value.text) * 5;
          totalValueOld.value = 10 + int.parse(myController.value.text) * 5;
          userValueOld.value = int.parse(myController.value.text) * 5;
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
