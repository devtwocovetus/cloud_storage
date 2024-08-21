import 'package:cold_storage_flutter/models/client/client_inventory_unit_list.dart';
import 'package:cold_storage_flutter/models/inventory/inventory_units_list_model.dart';
import 'package:cold_storage_flutter/repository/client_repository/client_repository.dart';
import 'package:cold_storage_flutter/repository/inventory_repository/inventory_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ClientInventoryUnitsViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = ClientRepository();

  RxString logoUrl = ''.obs;
  RxString backOpration = ''.obs;
  RxString materialId = ''.obs;
  RxString materialName = ''.obs;
  RxString accountId = ''.obs;
  RxString accountName = ''.obs;
  RxString isManual = ''.obs;

  RxList<ClientInventoryUnit>? unitList = <ClientInventoryUnit>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      materialId.value = argumentData[0]['materialId'];
      materialName.value = argumentData[0]['materialName'];
      accountId.value = argumentData[0]['accountId'];
      accountName.value = argumentData[0]['accountName'];
      isManual.value = argumentData[0]['isManual'];
    }
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    inventoryUnitsListApi();
    super.onInit();
  }

  void inventoryUnitsListApi() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.getClientInventoryUnit(accountId.value.toString(),materialId.value.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        ClientInventoryUnitList inventoryUnitsListModel =
            ClientInventoryUnitList.fromJson(value);
        unitList?.value =
            inventoryUnitsListModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
