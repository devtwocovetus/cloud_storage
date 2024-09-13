import 'dart:convert';

import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:get/get.dart';

import '../../services/notification/fcm_notification_services.dart';

class HomeViewModel extends GetxController {
  RxString logoUrl = ''.obs;
  RxBool isEntity = false.obs;
  RxBool isClient = false.obs;
  RxBool isMaterial = false.obs;
  RxBool isAsset = false.obs;
  RxBool btnStatus = false.obs;

  @override
  void onInit() {
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    print('<><>##@@ ${Utils.decodedMap.toString()}');
    FCMNotificationService.instance.enableFCMNotification(true);
    super.onInit();
  }

  @override
  void dispose() {
    FCMNotificationService.instance.enableFCMNotification(false);
    super.dispose();
  }

  void logout() {
    UserPreference userPreference = UserPreference();
    userPreference.logout();
    Get.offAndToNamed(RouteName.loginView);
  }

  void userOption(int val) {
    btnStatus.value = true;
    if (val == 0) {
      isEntity.value = true;
      isClient.value = false;
      isMaterial.value = false;
      isAsset.value = false;
    } else if (val == 1) {
      isEntity.value = false;
      isClient.value = true;
      isMaterial.value = false;
      isAsset.value = false;
    } else if (val == 2) {
      isEntity.value = false;
      isClient.value = false;
      isMaterial.value = true;
      isAsset.value = false;
    } else if (val == 3) {
      isEntity.value = false;
      isClient.value = false;
      isMaterial.value = false;
      isAsset.value = true;
    }
  }
}
