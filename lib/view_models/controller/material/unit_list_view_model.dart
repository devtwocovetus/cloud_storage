import 'package:cold_storage_flutter/models/material/unit_list_model.dart';
import 'package:cold_storage_flutter/repository/material_repository/material_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class UnitListViewModel extends GetxController {
    dynamic argumentData = Get.arguments;
  final _api = MaterialRepository();

  RxString logoUrl = ''.obs;
  RxString backOpration = ''.obs;
  RxString materialId = '16'.obs;
  RxString categoryId = '1'.obs;

  RxString materialName = ''.obs;
  RxString materialNameId = ''.obs;
  RxString materialCategory = ''.obs;
  RxString materialCategoryId = ''.obs;
  RxString materialDescription = ''.obs;
  RxString mOUValue = ''.obs;
  RxString mOUType = ''.obs;
  RxString mouId = ''.obs;
  RxString mouName = ''.obs;

  RxList<Unit>? unitList = <Unit>[].obs;
  var isLoading = true.obs;


  @override
  void onInit() {
    if(argumentData != null){
      materialName.value = argumentData[0]['MaterialName'];
      materialNameId.value = argumentData[0]['MaterialNameId'];
      materialCategory.value = argumentData[0]['MaterialCategory'];
      materialCategoryId.value = argumentData[0]['MaterialCategoryId'];
      materialDescription.value = argumentData[0]['MaterialDescription'];
      mOUValue.value = argumentData[0]['MOUValue'];
      mOUType.value = argumentData[0]['MOUType'];
      mouId.value = argumentData[0]['MOUID'];
      mouName.value = argumentData[0]['MOUNAME'];
    }
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getMaterialUnitList();
    super.onInit();
  }

  void getMaterialUnitList() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.materialUnitListApi('?material_id=${materialNameId.value}&category_id=${materialCategoryId.value}').then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        UnitListModel unitListModel = UnitListModel.fromJson(value);
        unitList?.value = unitListModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
