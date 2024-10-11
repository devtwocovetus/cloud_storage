import 'package:cold_storage_flutter/models/inventory/inventory_units_list_model.dart';
import 'package:cold_storage_flutter/repository/inventory_repository/inventory_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

class InventoryUnitsViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = InventoryRepository();

  RxString backOpration = ''.obs;
  RxString materialId = ''.obs;
  RxString materialName = ''.obs;
  RxString entityName = ''.obs;
  RxString entityId = ''.obs;
  RxString entityType = ''.obs;
  RxString clientId = ''.obs;

  RxList<InventoryUnit>? unitList = <InventoryUnit>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      materialId.value = argumentData[0]['materialId'];
      materialName.value = argumentData[0]['materialName'];
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
      entityType.value = argumentData[0]['entityType'];
      clientId.value = argumentData[0]['clientId'];
    }
    inventoryUnitsListApi(materialId.value);
    super.onInit();
  }

  void inventoryUnitsListApi(String materialId) {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.inventoryUnitsListApi(materialId,entityId.value.toString(),entityType.value.toString(),clientId.value.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        InventoryUnitsListModel inventoryUnitsListModel =
            InventoryUnitsListModel.fromJson(value);
        unitList?.value =
            inventoryUnitsListModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }
}
