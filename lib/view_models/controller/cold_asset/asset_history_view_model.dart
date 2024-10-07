import 'package:cold_storage_flutter/models/client/client_list_model.dart';
import 'package:cold_storage_flutter/models/cold_asset/asset_history_model.dart';
import 'package:cold_storage_flutter/models/cold_asset/asset_list_model.dart';
import 'package:cold_storage_flutter/repository/cold_asset_repository/cold_asset_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../res/components/dropdown/model/dropdown_item_model.dart';

class AssetHistoryViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = ColdAssetRepository();

  RxList<History>? assetList = <History>[].obs;
  RxList<History>? assetListForSearch = <History>[].obs;
  RxString assetName = ''.obs;
  RxString assetId = ''.obs;
  RxString comeFrom = ''.obs;
  RxString assetStartDate = ''.obs;
  RxString assetEndDate = ''.obs;
  var isLoading = true.obs;

  final startDateController = TextEditingController().obs;
  final endDateController = TextEditingController().obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;

  final startFocusNode = FocusNode().obs;
  final endFocusNode = FocusNode().obs;

  @override
  void onInit() {
    if (argumentData != null) {
      assetName.value = argumentData[0]['assetName'];
      assetId.value = argumentData[0]['assetId'];
      comeFrom.value = argumentData[0]['from'];
    }
    getAssetHistoryList();
    super.onInit();
  }


  void searchFilter(String searchText) {
    searchController.value.text = searchText;
    List<History>? results = [];
    if(searchText.isEmpty) {
      results = assetListForSearch?.value;
      print(results);
    } else {
      results = assetListForSearch?.value.where((element) => element.assignToUserName!.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
    assetList?.value = results ?? [];
  }

  // ///Sorting Function start
  // List<DropdownItemModel> sortingItems = [
  //   DropdownItemModel(value: 1,title: 'A-Z'),
  //   DropdownItemModel(value: 2,title: 'Z-A'),
  //   DropdownItemModel(value: 3,title: 'Date ASC'),
  //   DropdownItemModel(value: 4,title: 'Date DESC'),
  // ];
  //
  // sortListByProperty(DropdownItemModel item){
  //   switch (item.value) {
  //     case 1:
  //       sortListAToZ();
  //       break;
  //     case 2:
  //       sortListZToA();
  //       break;
  //     case 3:
  //       sortListByDateAsc();
  //       break;
  //     case 4:
  //       sortListByDateDec();
  //       break;
  //   }
  // }
  //
  // sortListAToZ(){
  //   assetList!.sort((a, b) {
  //     return a.assignToUserName!.compareTo(b.assignToUserName!);
  //   });
  // }
  //
  // sortListZToA(){
  //   assetList!.sort((a, b) {
  //     return b.assignToUserName!.compareTo(a.assignToUserName!);
  //   });
  // }
  //
  // sortListByDateAsc(){
  //   assetList!.sort((a, b) {
  //     return a.createdAt!.compareTo(b.createdAt!);
  //   });
  // }
  //
  // sortListByDateDec(){
  //   assetList!.sort((a, b) {
  //     return b.createdAt!.compareTo(a.createdAt!);
  //   });
  // }
  // ///Sorting Function End

  void getAssetHistoryFilterList() {
   assetList?.clear();
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api
        .getAssetHistory(
            assetId.value, startDateController.value.text, endDateController.value.text)
        .then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        
      } else {
        AssetHistoryModel assetHistoryModel = AssetHistoryModel.fromJson(value);
        assetList?.value = assetHistoryModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void getAssetHistoryList() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api
        .getAssetHistory(
            assetId.value, assetStartDate.value, assetEndDate.value)
        .then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        AssetHistoryModel assetHistoryModel = AssetHistoryModel.fromJson(value);
        assetList?.value = assetHistoryModel.data!.map((data) => data).toList();
        assetListForSearch?.value = assetList!.value;

      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
