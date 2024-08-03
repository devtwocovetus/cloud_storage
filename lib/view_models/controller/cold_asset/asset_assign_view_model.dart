import 'package:cold_storage_flutter/models/cold_asset/asset_location_model.dart';
import 'package:cold_storage_flutter/models/home/user_list_model.dart';
import 'package:cold_storage_flutter/repository/cold_asset_repository/cold_asset_repository.dart';
import 'package:cold_storage_flutter/view_models/controller/cold_asset/asset_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';

class AssetAssignViewModel extends GetxController {
  final _api = ColdAssetRepository();

  var assetUserList = <String>[].obs;
  var assetUserListId = <int?>[].obs;
  RxString assetUser = ''.obs;

  var assetLocationList = <String>[].obs;
  var assetLocationListId = <int?>[].obs;
  var assetLocationListType = <int?>[].obs;
  RxString assetLocation = ''.obs;


  RxString assetLocationId = ''.obs;
  RxString assetLocationType = ''.obs;




  final endDateController = TextEditingController().obs;
  final usageController = TextEditingController().obs;
  final noteController = TextEditingController().obs;

  final endDateFocusNode = FocusNode().obs;
  final usageFocusNode = FocusNode().obs;
  final noteFocusNode = FocusNode().obs;
  RxBool isUser = false.obs;

  @override
  void onInit() {
    getLocation();
    super.onInit();
  }

  Future getUser() async {
    Map data = {
      'to_location_or_entity_type':assetLocationType.value.toString(),
      'to_location_or_entity':assetLocationId.value.toString(),
      
    };
    EasyLoading.show(status: 'loading...');
    _api.getUserList(data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        UserListModel userListModel = UserListModel.fromJson(value);
        assetUserList.value = userListModel.data!.users!
            .map((data) => Utils.textCapitalizationString(data.name!))
            .toList();
        assetUserListId.value =
            userListModel.data!.users!.map((data) => data.id).toList();
        isUser.value = true;
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future getLocation() async {
    EasyLoading.show(status: 'loading...');
    _api.getLocation().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        AssetLocationModel assetLocationModel =
            AssetLocationModel.fromJson(value);
        assetLocationList.value = assetLocationModel.data!
            .map((data) => Utils.textCapitalizationString(data.name!))
            .toList();
        assetLocationListId.value =
            assetLocationModel.data!.map((data) => data.id).toList();
        assetLocationListType.value =
            assetLocationModel.data!.map((data) => data.entityType).toList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void submitAddAssign(BuildContext context, String assetId, String locationId,
      String locationType) {
    int indexLocation =
        assetLocationList.indexOf(assetLocation.toString().trim());
    int indexUser = assetUserList.indexOf(assetUser.toString().trim());
    EasyLoading.show(status: 'loading...');
    Map data = {
      'asset_id': assetId,
      'from_location_or_entity': locationId,
      'from_location_or_entity_type': locationType,
      'to_location_or_entity': assetLocationListId[indexLocation].toString(),
      'to_location_or_entity_type':
          assetLocationListType[indexLocation].toString(),
      'assign_to_user': assetUserListId[indexUser].toString(),
      'end_date': endDateController.value.text.toString(),
      'usages': usageController.value.text.toString(),
      'note': noteController.value.text.toString(),
    };
    _api.postAddAssign(data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.snackBar('Success', 'Asset assign successfully');
        final assetListViewModel = Get.put(AssetListViewModel());
        assetListViewModel.getAssetList();
        Navigator.pop(context);
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
