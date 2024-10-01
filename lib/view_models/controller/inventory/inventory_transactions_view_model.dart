import 'package:cold_storage_flutter/models/inventory/inventory_transactions_list_model.dart';
import 'package:cold_storage_flutter/repository/inventory_repository/inventory_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../res/components/dropdown/model/dropdown_item_model.dart';

class InventoryTransactionsViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = InventoryRepository();

  RxString backOpration = ''.obs;
  RxString materialId = ''.obs;
  RxString materialName = ''.obs;
  RxString entityName = ''.obs;
  RxString entityId = ''.obs;
  RxString entityType = ''.obs;
  RxString unitId = ''.obs;
  RxString categoryId = ''.obs;
  RxString unitName = ''.obs;
  // RxString clientId = ''.obs;

  RxList<Transaction>? transactionList = <Transaction>[].obs;
  RxList<Transaction>? transactionListForSearch = <Transaction>[].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      materialId.value = argumentData[0]['materialId'];
      unitId.value = argumentData[0]['unitId'];
      categoryId.value = argumentData[0]['categoryId'];
      unitName.value = argumentData[0]['unitName'];
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
      entityType.value = argumentData[0]['entityType'];
      // clientId.value = argumentData[0]['clientId'];
    }
    print('<><><><>### $unitId');
    inventoryTransactionsListApi();
    super.onInit();
  }

  void searchFilter(String searchText) {
    List<Transaction>? results = [];
    if(searchText.isEmpty) {
      results = transactionListForSearch?.value;
      print(results);
    } else {
      results = transactionListForSearch?.value.where((element) => element.transactionDate!.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
    transactionList?.value = results ?? [];
  }

  ///Sorting Function start
  List<DropdownItemModel> sortingItems = [
    DropdownItemModel(value: 1,title: 'Date Ascending'),
    DropdownItemModel(value: 2,title: 'Date Descending'),
    DropdownItemModel(value: 3,title: 'Quantity Ascending'),
    DropdownItemModel(value: 4,title: 'Quantity Descending'),
  ];

  sortListByProperty(DropdownItemModel item){
    switch (item.value) {
      case 1:
        sortListByDateAsc();
        break;
      case 2:
        sortListByDateDec();
        break;
      case 3:
        sortListByDateAsc();
        break;
      case 4:
        sortListByQuantityDec();
        break;
    }
  }

  sortListByDateAsc(){
    transactionList!.sort((a, b) {
      return a.transactionDate!.compareTo(b.transactionDate!);
    });
  }

  sortListByDateDec(){
    transactionList!.sort((a, b) {
      return b.transactionDate!.compareTo(a.transactionDate!);
    });
  }

  sortListByQuantityAsc(){
    transactionList!.sort((a, b) {
      return a.receivedQuantity!.compareTo(b.receivedQuantity!);
    });
  }

  sortListByQuantityDec(){
    transactionList!.sort((a, b) {
      return b.receivedQuantity!.compareTo(a.receivedQuantity!);
    });
  }
  ///Sorting Function End

  void inventoryTransactionsListApi() {
      isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.inventoryTransactionsListApi(unitId.value.toString(),categoryId.value.toString(),materialId.value.toString(),entityId.value.toString(),entityType.value.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        InventoryTransactionListModel inventoryTransactionListModel =
            InventoryTransactionListModel.fromJson(value);
        transactionList?.value =
            inventoryTransactionListModel.data!.map((data) => data).toList();
        transactionListForSearch?.value = transactionList!.value;
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
