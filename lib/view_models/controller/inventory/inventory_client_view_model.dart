import 'package:cold_storage_flutter/models/inventory/inventory_client_list_model.dart';
import 'package:cold_storage_flutter/models/material/material_list_model.dart';
import 'package:cold_storage_flutter/repository/inventory_repository/inventory_repository.dart';
import 'package:cold_storage_flutter/repository/material_repository/material_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class InventoryClientViewModel extends GetxController {
    dynamic argumentData = Get.arguments;
  final _api = InventoryRepository();

  RxString logoUrl = ''.obs;
  RxString backOpration = ''.obs;

  RxList<InventoryClient>? clientList = <InventoryClient>[].obs;
  var isLoading = true.obs;
  RxString entityName = ''.obs;
  RxString entityId = ''.obs;
  RxString entityType = ''.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
      entityType.value = argumentData[0]['entityType'];
    }
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    inventoryClientList();
    super.onInit();
  }

   
  void inventoryClientList() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.inventoryClientListApi(entityId.value.toString(),entityType.value.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        InventoryClientListModel inventoryClientListModel = InventoryClientListModel.fromJson(value);
        clientList?.value = inventoryClientListModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
