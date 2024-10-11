import 'package:cold_storage_flutter/models/inventory/inventory_client_list_model.dart';
import 'package:cold_storage_flutter/repository/inventory_repository/inventory_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

class InventoryClientViewModel extends GetxController {
    dynamic argumentData = Get.arguments;
  final _api = InventoryRepository();

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
    inventoryClientList();
    super.onInit();
  }

   
  void inventoryClientList() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
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
      Utils.snackBar(t.error_text, error.toString());
    });
  }
}
