import 'package:cold_storage_flutter/models/material/material_list_model.dart';
import 'package:cold_storage_flutter/repository/material_repository/material_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class MateriallistViewModel extends GetxController {
  final _api = MaterialRepository();

  RxString backOpration = ''.obs;

  RxList<MaterialItem>? materialList = <MaterialItem>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getMaterialList();
    super.onInit();
  }

  void deleteMaterial(String id) {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.deleteMaterialApi(id).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Success', 'Record has been successfully deleted');
        getMaterialList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void getMaterialList() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.materialListApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        materialList = <MaterialItem>[].obs;
      } else {
        MaterialListModel materialListModel = MaterialListModel.fromJson(value);
        materialList?.value =
            materialListModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
