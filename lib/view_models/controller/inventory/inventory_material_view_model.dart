import 'package:cold_storage_flutter/models/inventory/inventory_client_list_model.dart';
import 'package:cold_storage_flutter/models/inventory/inventory_material_list_model.dart';
import 'package:cold_storage_flutter/models/material/material_list_model.dart';
import 'package:cold_storage_flutter/repository/inventory_repository/inventory_repository.dart';
import 'package:cold_storage_flutter/repository/material_repository/material_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class InventoryMaterialViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = InventoryRepository();

  RxString logoUrl = ''.obs;
  RxString backOpration = ''.obs;
  RxString clientId = ''.obs;
  RxString clientName = ''.obs;
  RxString entityName = ''.obs;
  RxString entityId = ''.obs;
  RxString entityType = ''.obs;

  RxList<InventoryMaterial>? materialList = <InventoryMaterial>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      clientId.value = argumentData[0]['clientId'];
      clientName.value = argumentData[0]['clientName'];
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
      entityType.value = argumentData[0]['entityType'];
    }
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    inventoryMaterialList(clientId.value);
    super.onInit();
  }

  void inventoryMaterialList(String clientId) {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.inventoryMaterialListApi(clientId,entityId.value.toString(),entityType.value.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        InventoryMaterialListModel inventoryMaterialListModel =
            InventoryMaterialListModel.fromJson(value);
        materialList?.value =
            inventoryMaterialListModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
