import 'package:cold_storage_flutter/models/client/client_inventory_material_list.dart';
import 'package:cold_storage_flutter/repository/client_repository/client_repository.dart';
import 'package:cold_storage_flutter/res/components/dropdown/model/dropdown_item_model.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

class ClientInventoryMaterialViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = ClientRepository();

  RxString backOpration = ''.obs;
  RxString accountId = ''.obs;
  RxString accountName = ''.obs;
  RxString isManual = ''.obs;

  RxList<ClientInventoryMaterial>? materialList = <ClientInventoryMaterial>[].obs;
  RxList<ClientInventoryMaterial>? materialListForSearch = <ClientInventoryMaterial>[].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
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


  ///Sorting Function start
  List<DropdownItemModel> sortingItems = [
    DropdownItemModel(value: 1,title: 'A-Z'),
    DropdownItemModel(value: 2,title: 'Z-A'),
    DropdownItemModel(value: 3,title: 'Date ASC'),
    DropdownItemModel(value: 4,title: 'Date DESC'),
    DropdownItemModel(value: 5,title: 'Quantity ASC'),
    DropdownItemModel(value: 6,title: 'Quantity DESC'),
  ];

  sortListByProperty(DropdownItemModel item){
    switch (item.value) {
      case 1:
        sortListAToZ();
        break;
      case 2:
        sortListZToA();
        break;
      case 3:
        sortListByDateAsc();
        break;
      case 4:
        sortListByDateDec();
        break;
      case 5:
        sortListByQuantityAsc();
        break;
      case 6:
        sortListByQuantityDec();
        break;
    }
  }

  sortListAToZ(){
    materialList!.sort((a, b) {
      return a.materialName!.compareTo(b.materialName!);
    });
  }

  sortListZToA(){
    materialList!.sort((a, b) {
      return b.materialName!.compareTo(a.materialName!);
    });
  }

  sortListByDateAsc(){
    materialList!.sort((a, b) {
      return a.createdAt!.compareTo(b.createdAt!);
    });
  }

  sortListByDateDec(){
    materialList!.sort((a, b) {
      return b.createdAt!.compareTo(a.createdAt!);
    });
  }

  sortListByQuantityAsc(){
    materialList!.sort((a, b) {
      return a.totalQuantity!.compareTo(b.totalQuantity!);
    });
  }

  sortListByQuantityDec(){
    materialList!.sort((a, b) {
      return b.totalQuantity!.compareTo(a.totalQuantity!);
    });
  }
  ///Sorting Function End

  void inventoryMaterialList(String clientId) {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
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
      Utils.snackBar(t.error, error.toString());
    });
  }
}
