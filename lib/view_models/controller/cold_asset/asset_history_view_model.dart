
import 'package:cold_storage_flutter/models/client/client_list_model.dart';
import 'package:cold_storage_flutter/models/cold_asset/asset_history_model.dart';
import 'package:cold_storage_flutter/models/cold_asset/asset_list_model.dart';
import 'package:cold_storage_flutter/repository/cold_asset_repository/cold_asset_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AssetHistoryViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = ColdAssetRepository();

  RxList<History>? assetList = <History>[].obs;
  RxString logoUrl = ''.obs;
  RxString assetName = ''.obs;
  RxString assetId = ''.obs;
  RxString assetStartDate = ''.obs;
  RxString assetEndDate = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
     if (argumentData != null) {
      assetName.value = argumentData[0]['assetName'];
      assetId.value = argumentData[0]['assetId'];
    }
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getAssetHistoryList();
    super.onInit();
  }

void getAssetHistoryList() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.getAssetHistory(assetId.value,assetStartDate.value,assetEndDate.value).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
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
}
