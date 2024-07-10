import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:get/get.dart';

class EntityOnboardingViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  RxString logoUrl = ''.obs;
  RxBool isColdWarehouse = false.obs;
  RxBool isFarmGrower = false.obs;
  RxBool btnStatus = false.obs;
  RxString inComingStatus = ''.obs;

  @override
  void onInit() {
    if(argumentData != null){
      inComingStatus.value = argumentData[0]['EOB'];
    }
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });

    super.onInit();
  }

  void userOption(int val) {
    btnStatus.value = true;
    if (val == 0) {
      isColdWarehouse.value = true;
      isFarmGrower.value = false;
    } else if (val == 1) {
    isColdWarehouse.value = false;
      isFarmGrower.value = true;
    } 
  }
}
