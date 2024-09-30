import 'package:cold_storage_flutter/models/client/client_inventory_material_list.dart';
import 'package:cold_storage_flutter/repository/client_repository/client_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ClientInventoryMaterialViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = ClientRepository();

  RxString backOpration = ''.obs;
  RxString accountId = ''.obs;
  RxString accountName = ''.obs;
  RxString isManual = ''.obs;

  RxList<ClientInventoryMaterial>? materialList = <ClientInventoryMaterial>[].obs;
  RxList<ClientInventoryMaterial>? materialListForSearch = <ClientInventoryMaterial>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      accountId.value = argumentData[0]['accountId'];
      accountName.value = argumentData[0]['accountName'];
      isManual.value = argumentData[0]['isManual'];
    }
    inventoryMaterialList(accountId.value);
    super.onInit();
  }

  void searchFilter(String searchText) {
    List<ClientInventoryMaterial>? results = [];
    if(searchText.isEmpty) {
      results = materialListForSearch?.value;
      print(results);
    } else {
      results = materialListForSearch?.value.where((element) => element.materialName!.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
    materialList?.value = results ?? [];
  }

  void inventoryMaterialList(String clientId) {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.getClientInventoryMaterial(clientId).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
        materialList!.value = <ClientInventoryMaterial>[].obs;
      } else {
        ClientInventoryMaterialList inventoryMaterialListModel =
            ClientInventoryMaterialList.fromJson(value);
        materialList?.value =
            inventoryMaterialListModel.data!.map((data) => data).toList();
        materialListForSearch?.value = materialList!.value;
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
