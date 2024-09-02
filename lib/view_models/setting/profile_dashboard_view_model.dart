import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:get/get.dart';

class ProfileDashboardViewModel extends GetxController {
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
    super.onInit();
  }

  void logout() {
    UserPreference userPreference = UserPreference();
    userPreference.logout();
    Get.offAndToNamed(RouteName.loginView);
  }


}
