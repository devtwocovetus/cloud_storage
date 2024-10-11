
import 'package:cold_storage_flutter/models/client/client_list_model.dart';
import 'package:cold_storage_flutter/models/cold_asset/asset_list_model.dart';
import 'package:cold_storage_flutter/repository/cold_asset_repository/cold_asset_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../i10n/strings.g.dart';

class AssetListViewModel extends GetxController {
   dynamic argumentData = Get.arguments;
  final _api = ColdAssetRepository();

  RxList<AssetList>? assetList = <AssetList>[].obs;
  RxList<AssetList>? assetListForSearch = <AssetList>[].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  var isLoading = true.obs;
    RxString comeFrom = ''.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      comeFrom.value = argumentData[0]['from'];
    }
    getAssetList();
    super.onInit();
  }

   void searchFilter(String searchText) {
     List<AssetList>? results = [];
     if(searchText.isEmpty) {
       results = assetListForSearch?.value;
       print(results);
     } else {
       results = assetListForSearch?.value.where((element) => element.assetName!.toLowerCase().contains(searchText.toLowerCase())).toList();
     }
     assetList?.value = results ?? [];
   }

void getAssetList() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.getAssetList().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        AssetListModel assetListModel = AssetListModel.fromJson(value);
        assetList?.value = assetListModel.data!.map((data) => data).toList();
        assetListForSearch?.value = assetList!.value;
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void deleteAssign(String assignId) {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.deletAssign(assignId).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar(t.success_text, t.asset_success_release_text);
        getAssetList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }
}
