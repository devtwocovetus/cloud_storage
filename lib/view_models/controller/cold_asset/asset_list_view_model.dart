
import 'package:cold_storage_flutter/models/client/client_list_model.dart';
import 'package:cold_storage_flutter/models/cold_asset/asset_list_model.dart';
import 'package:cold_storage_flutter/repository/cold_asset_repository/cold_asset_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AssetListViewModel extends GetxController {
  final _api = ColdAssetRepository();

  RxList<AssetList>? assetList = <AssetList>[].obs;
  RxString logoUrl = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getAssetList();
    super.onInit();
  }

void getAssetList() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.getAssetList().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        AssetListModel assetListModel = AssetListModel.fromJson(value);
        assetList?.value = assetListModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
