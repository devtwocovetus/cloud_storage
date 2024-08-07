import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:get/get.dart';

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

    super.onInit();
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
