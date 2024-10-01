import 'package:cold_storage_flutter/models/transaction_log/transaction_log_list_model.dart';
import 'package:cold_storage_flutter/repository/transaction_log_repository/transaction_log_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../res/components/dropdown/model/dropdown_item_model.dart';

class TransactionLogListViewModel extends GetxController {
    dynamic argumentData = Get.arguments;
  final _api = TransactionLogRepository();

  RxString backOpration = ''.obs;

  RxList<TransactionLogItem>? transactionLogList = <TransactionLogItem>[].obs;
  RxList<TransactionLogItem>? transactionLogListForSearch = <TransactionLogItem>[].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
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
    getTransactionLogList();
    super.onInit();
  }

  void searchFilter(String searchText) {
    List<TransactionLogItem>? results = [];
    if(searchText.isEmpty) {
      results = transactionLogListForSearch?.value;
      print(results);
    } else {
      results = transactionLogListForSearch?.value.where((element) {
        if(element.vendorClientName != null && element.vendorClientName.toString().isNotEmpty && element.vendorClientName!.toLowerCase().contains(searchText.toLowerCase()) && element.transactionType == 'IN'){
          print('<><>call1');
          return true;
        }else
         if(element.customerClientName != null && element.customerClientName.toString().isNotEmpty && element.customerClientName!.toLowerCase().contains(searchText.toLowerCase()) && element.transactionType == 'OUT'){
          print('<><>call2');
          return true;
        }else
         if(element.senderAccount != null && element.senderAccount.toString().isNotEmpty && element.senderAccount!.toLowerCase().contains(searchText.toLowerCase()) && element.transactionType == 'TRANSFERIN' || element.transactionType == 'TRANSFEROUT'){
          print('<><>call3');
          return true;
        }else {
           return false;
         }
      }).toList();
    }
    transactionLogList?.value = results ?? [];
  }

    ///Sorting Function start
    List<DropdownItemModel> sortingItems = [
      DropdownItemModel(value: 1,title: 'A-Z'),
      DropdownItemModel(value: 2,title: 'Z-A'),
      DropdownItemModel(value: 3,title: 'Date Ascending'),
      DropdownItemModel(value: 4,title: 'Date Descending'),
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

      }
    }

    sortListAToZ(){
      // transactionLogList!.sort((a, b) {
      //   return a.materialName!.compareTo(b.materialName!);
      // });
    }

    sortListZToA(){
      // transactionLogList!.sort((a, b) {
      //   return b.materialName!.compareTo(a.materialName!);
      // });
    }

    sortListByDateAsc(){
      transactionLogList!.sort((a, b) {
        return a.transactionDate!.compareTo(b.transactionDate!);
      });
    }

    sortListByDateDec(){
      transactionLogList!.sort((a, b) {
        return b.transactionDate!.compareTo(a.transactionDate!);
      });
    }
    ///Sorting Function End

    void getTransactionLogList() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.transactionClientListApi(entityId.value.toString(),entityType.value.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        TransactionLogListModel transactionLogListModel = TransactionLogListModel.fromJson(value);
        transactionLogList?.value = transactionLogListModel.data!.map((data) => data).toList();
        transactionLogListForSearch?.value = transactionLogList!.value;
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
