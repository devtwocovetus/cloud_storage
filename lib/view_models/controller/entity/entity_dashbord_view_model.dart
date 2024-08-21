import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:get/get.dart';

class EntityDashbordViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  RxString logoUrl = ''.obs;
  RxString entityName = ''.obs;
  RxString entityId = ''.obs;
  RxString entityType = ''.obs;


  @override
  void onInit() {
    if(argumentData!= null){
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
      entityType.value = argumentData[0]['entityType'];
    }
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    super.onInit();
  }

  
}
