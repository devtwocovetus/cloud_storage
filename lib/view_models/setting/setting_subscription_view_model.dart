import 'package:cold_storage_flutter/models/client/client_list_model.dart';
import 'package:cold_storage_flutter/repository/stripe_repository/stripe_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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



  RxString mStrPlanId = ''.obs;
  RxInt mIntUserCount = 0.obs;
  RxInt mIntUserId = 0.obs;
  RxInt mIntAccountId = 0.obs;
  RxInt mFinalUserCount = 0.obs;





  RxInt totalValue = 299.obs;
  RxInt userValue = 0.obs;
  RxInt totalValueOld = 299.obs;
  RxInt userValueOld = 0.obs;
  RxBool isIncrees = false.obs;
  final myController = TextEditingController(text: '0').obs;

  @override
  void onInit() {
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
    _api.getUserData().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {

   mStrSubscriptionId.value = value['data']['subscriptionModel']['subscription_id'];
   mStrCustomerId.value = value['data']['subscriptionModel']['customer_id'];

   mStrBasePlanSubPlanId.value = value['data']['subscriptionModel']['base_plan']['subscription_plan_id'];
   mStrBasePlanSubItemId.value = value['data']['subscriptionModel']['base_plan']['subscription_item_id'];
   mStrBasePlanSubQuantity.value = value['data']['subscriptionModel']['base_plan']['quantity'];
  
  
   mStrUserPlanSubPlanId.value = value['data']['subscriptionModel']['user_plan']['subscription_plan_id'];
   mStrUserPlanSubItemId.value = value['data']['subscriptionModel']['user_plan']['subscription_item_id'];
   mStrUserPlanSubQuantity.value = value['data']['subscriptionModel']['user_plan']['quantity'];



        // mStrSubscriptionId.value = value['data']['subscription_id'].toString();
        // mStrStripeCustomerId.value =
        //     value['data']['stripe_customer_id'].toString();
        // mStrPlanId.value = value['data']['plan_id'].toString();
        // mIntUserCount.value = value['data']['user_count'];
        // mIntUserId.value = value['data']['user_id'];
        // mIntAccountId.value = value['data']['account_id'];
        // myController.value.text = mIntUserCount.value.toString();

        if (mStrUserPlanSubQuantity.value == 1) {
          totalValue.value = 299;
          userValue.value = 0;
        } else {
          totalValue.value = 200 + mStrUserPlanSubQuantity.value * 99;
          int currentUser = mStrUserPlanSubQuantity.value - 1;
          userValue.value = currentUser * 99;
          totalValueOld.value = 200 + mStrUserPlanSubQuantity.value * 99;
          userValueOld.value = currentUser * 99;
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
