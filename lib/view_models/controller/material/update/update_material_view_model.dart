import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../models/material/material_categorie_model.dart';
import '../../../../models/material/measurement_unit_mou.dart';
import '../../../../models/material/measurement_units_type.dart';
import '../../../../repository/material_repository/material_repository.dart';
import '../../../../res/routes/routes_name.dart';
import '../../../../utils/utils.dart';
import '../../user_preference/user_prefrence_view_model.dart';
import '../materiallist_view_model.dart';

class UpdateMaterialViewModel extends GetxController{
  dynamic argumentData = Get.arguments;
  final _api = MaterialRepository();

  final nameController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;

  final nameFocusNode = FocusNode().obs;
  final descriptionFocusNode = FocusNode().obs;

  RxList<MaterialCategorie> categoryList = <MaterialCategorie>[].obs;
  MaterialCategorie? materialCategory;
  RxList<UnitType> unitTypeList = <UnitType>[].obs;
  UnitType? unitType;
  RxList<MouList> mouList = <MouList>[].obs;
  MouList? mou;

  RxString logoUrl = ''.obs;
  var isLoading = true.obs;
  RxMap<String,dynamic> updatingMaterial = <String, dynamic>{}.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      updatingMaterial.value = jsonDecode(argumentData);
    }
    log('material11 : ${updatingMaterial.toString()}');
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getMaterialCategory();
    getMaterialUnitType();
    assignInitialValues();
    super.onInit();
  }

  assignInitialValues(){
    print('material12 : ${updatingMaterial['name']}');
    nameController.value.text = updatingMaterial['name'];
    descriptionController.value.text = updatingMaterial['description'];
    // valueController.value.text = updatingMaterial[''];
  }

  void getMaterialCategory() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.materialCategorieListApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialCategorieModel userRole = MaterialCategorieModel.fromJson(value);
        categoryList.value = userRole.data!.map((data) => data).toList();
        // categoryListId.value = userRole.data!.map((data) => data.id).toList();
        if(categoryList.value.isNotEmpty){
          int index = categoryList.value.indexWhere((e) {
            return e.id == updatingMaterial['category_id'];
          });
          materialCategory = categoryList.value[index];
          log('materialCategory?.value 1: $materialCategory');
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void getMaterialUnitType() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.unitTypeListApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MeasurementUnitsType measurementUnitsType = MeasurementUnitsType.fromJson(value);
        unitTypeList.value = measurementUnitsType.data!.map((data) => data).toList();
        if(unitTypeList!.value.isNotEmpty){
          int index = unitTypeList!.value.indexWhere((e) {
            return e.unitType == updatingMaterial['mou_type'];
          });
          unitType = unitTypeList!.value[index];
          getMouList(unitType!.unitType!);
          log('unitType?.value 1: $unitType');
        }else{
          // unitType.value = 'Type';
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void getMouList(String unitType) {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {'unit_type': unitType};
    _api.unitMouListApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Login', value['message']);
      } else {
        MeasurementUnitMou measurementUnitmou = MeasurementUnitMou.fromJson(value);
        mouList.value = measurementUnitmou.data!.map((data) =>data).toList();
        if(mouList!.value.isNotEmpty){
          int index = mouList!.value.indexWhere((e) {
            return e.id == updatingMaterial['mou_id'];
          });
          mou = mouList!.value[index];
          log('unitType?.value 1: $unitType');
        }else{
          // unitMou.value = '';
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future<void> updateMaterial()  async {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'name': nameController.value.text,
      'category': materialCategory?.id.toString(),
      'description': descriptionController.value.text,
      'mou_id': mou?.id.toString(),
      'status': "1"
    };
    _api.updateMaterialApi(data: data,id: updatingMaterial['id']).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Material', 'Material updated successfully');
        final materiallistViewModel = Get.put(MateriallistViewModel());
        materiallistViewModel.getMaterialList();
        Get.until((route) => Get.currentRoute == RouteName.materialListScreen);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.isCheck = true;
      Utils.snackBar('Error', error.toString());
    });
  }

}