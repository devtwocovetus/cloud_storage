import 'dart:convert';
import 'dart:developer';
import 'package:cold_storage_flutter/i10n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../models/material/material_categorie_model.dart';
import '../../../../models/material/measurement_unit_mou.dart';
import '../../../../models/material/measurement_units_type.dart';
import '../../../../repository/material_repository/material_repository.dart';
import '../../../../res/routes/routes_name.dart';
import '../../../../utils/utils.dart';
import '../../material/materiallist_view_model.dart';
import '../../user_preference/user_prefrence_view_model.dart';

class UpdateMaterialViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = MaterialRepository();
  RxString materialUOM = ''.obs;
  final nameController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  final unitNameController = TextEditingController().obs;

  final nameFocusNode = FocusNode().obs;
  final descriptionFocusNode = FocusNode().obs;
  final unitNameFocusNode = FocusNode().obs;

  RxList<MaterialCategorie> categoryList = <MaterialCategorie>[].obs;
  MaterialCategorie? materialCategory;
  RxList<UnitType> unitTypeList = <UnitType>[].obs;
  UnitType? unitType;

  var mouList = <String>[].obs;

  var mouListId = <int?>[].obs;

  var isLoading = true.obs;
  RxMap<String, dynamic> updatingMaterial = <String, dynamic>{}.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      updatingMaterial.value = jsonDecode(argumentData);
      print('<><>##### ${updatingMaterial.value.toString()}');
    }
    log('material11 : ${updatingMaterial.toString()}');
    getMaterialCategory();
    getMouList();
    assignInitialValues();
    super.onInit();
  }

  assignInitialValues() {
    print('material12 : ${updatingMaterial['name']}');
    nameController.value.text = updatingMaterial['name'];
    if (updatingMaterial['description'].toString() == 'null') {
      descriptionController.value.text = '';
    } else {
      descriptionController.value.text = updatingMaterial['description'].toString();
    }

    materialUOM.value = updatingMaterial['mou_name'];
    // valueController.value.text = updatingMaterial[''];
  }

  void getMaterialCategory() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.materialCategorieListApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialCategorieModel userRole =
            MaterialCategorieModel.fromJson(value);
        categoryList.value = userRole.data!.map((data) => data).toList();
        // categoryListId.value = userRole.data!.map((data) => data.id).toList();
        if (categoryList.value.isNotEmpty) {
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
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void getMouList() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    Map data = {'unit_type': 'Count'};
    _api.unitMouListApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Login', value['message']);
      } else {
        print('##<><> ${value.toString()}');
        MeasurementUnitMou measurementUnitmou =
            MeasurementUnitMou.fromJson(value);
        mouList.value = measurementUnitmou.data!
            .map((data) => Utils.textCapitalizationString(data.unitName!))
            .toList();
        mouListId.value =
            measurementUnitmou.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  Future<void> updateMaterial() async {
    int indexMou = mouList.indexOf(materialUOM.toString());
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    Map data = {
      'name': Utils.textCapitalizationString(nameController.value.text),
      'category': materialCategory?.id.toString(),
      'description': Utils.textCapitalizationString(descriptionController.value.text),
      'mou_id': mouListId[indexMou].toString(),
      'mou_other_name': Utils.textCapitalizationString(unitNameController.value.text),
      'status': "1"
    };
    _api
        .updateMaterialApi(data: data, id: updatingMaterial['id'])
        .then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar(t.material_text, t.text_material_updated);
        final materiallistViewModel = Get.put(MateriallistViewModel());
        materiallistViewModel.getMaterialList();
        Get.until((route) => Get.currentRoute == RouteName.materialListScreen);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.isCheck = true;
      Utils.snackBar(t.error_text, error.toString());
    });
  }
}
