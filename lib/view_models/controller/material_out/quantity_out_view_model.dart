import 'package:cold_storage_flutter/models/material_in/material_in_bin_model.dart';
import 'package:cold_storage_flutter/models/material_in/material_in_category_model.dart';
import 'package:cold_storage_flutter/models/material_in/material_in_material_model.dart';
import 'package:cold_storage_flutter/models/material_in/material_in_unit_model.dart';
import 'package:cold_storage_flutter/models/material_out/material_available_quantity_model.dart';
import 'package:cold_storage_flutter/repository/material_out_repository/material_out_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/controller/material_out/material_out_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

class QuantityOutViewModel extends GetxController {
  final _api = MaterialOutRepository();
  dynamic argumentData = Get.arguments;
  var categoryList = <String>[].obs;
  var categoryListId = <int?>[].obs;

  var materialList = <String>[].obs;
  var materialListId = <int?>[0].obs;

  var unitList = <String>[].obs;
  var unitListMouName = <String>[].obs;
  var unitListUnitQuantity = <int>[0].obs;
  var unitListId = <int?>[0].obs;

  var binList = <String>['Select Bin'].obs;
  var binListId = <int?>[0].obs;

  RxString mStrcategory = ''.obs;
  RxString mStrmaterial = ''.obs;
  RxString mStrUnit = ''.obs;
  RxString mStrBin = ''.obs;

  RxString mStrBinId = ''.obs;
  RxString entityName = ''.obs;
  RxString entityType = ''.obs;
  RxString entityId = ''.obs;
  RxString clientId = ''.obs;

  final quantityController = TextEditingController().obs;
  final quantityFocus = FocusNode().obs;

  final noteController = TextEditingController().obs;
  final noteFocus = FocusNode().obs;

  final availableQuantityController = TextEditingController().obs;
  final availableQuantityFocus = FocusNode().obs;

  RxList<Map<String, dynamic>> imageList = <Map<String, dynamic>>[].obs;
  RxList<String> image64List = <String>[].obs;

  RxBool isBreakage = false.obs;
  RxBool isavailableQuantity = false.obs;
  RxBool isaMaterial = false.obs;
  RxBool isUnit = false.obs;
  RxBool isBin = false.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
      entityType.value = argumentData[0]['entityType'];
    }
    getMaterialCategorie();
    super.onInit();
  }

  addImageToList(Map<String, dynamic> img) {
    imageList.add(img);
    image64List.add(img['imgBase']);
  }

  removeImageToList(Map<String, dynamic> img) {
    imageList.remove(img);
    image64List.remove(img['imgBase']);
  }

  void getMaterialCategorie() {
    Map data = {
      'entity_id': entityId.value.toString(),
      'entity_type': entityType.value.toString()
    };
    EasyLoading.show(status: t.loading);
    _api.getCategorieMaterialOut(data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialInCategoryModel materialInCategoryModel =
            MaterialInCategoryModel.fromJson(value);
        categoryList.value = materialInCategoryModel.data!
            .map((data) => Utils.textCapitalizationString(data.name!))
            .toList();
        categoryListId.value =
            materialInCategoryModel.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void getMaterial() {
    int index = categoryList.indexOf(mStrcategory.trim());
    Map data = {
      'entity_id': entityId.value.toString(),
      'entity_type': entityType.value.toString(),
      'category_id': categoryListId[index].toString()
    };
    EasyLoading.show(status: t.loading);
    _api.getMaterialListForOut(data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        MaterialInMaterialModel materialInMaterialModel =
            MaterialInMaterialModel.fromJson(value);
        materialList.value =
            materialInMaterialModel.data!.map((data) => data.name!).toList();
        materialListId.value =
            materialInMaterialModel.data!.map((data) => data.id).toList();
        isaMaterial.value = true;
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

   void getUnit() {
  int indexCat = categoryList.indexOf(mStrcategory.trim());
    int indexMat = materialList.indexOf(mStrmaterial.trim());
    Map data = {
      'entity_id': entityId.value.toString(),
      'entity_type': entityType.value.toString(),
      'category_id': categoryListId[indexCat].toString(),
      'material_id': materialListId[indexMat].toString()
    };
    EasyLoading.show(status: t.loading);
    _api.getUnitForMateralOut(data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialInUnitModel materialInUnitModel =
            MaterialInUnitModel.fromJson(value);
        unitList.value =
            materialInUnitModel.data!.map((data) => Utils.textCapitalizationString(data.unitName!)).toList();
        unitListMouName.value =
            materialInUnitModel.data!.map((data) => Utils.textCapitalizationString(data.mouName!)).toList();
        unitListUnitQuantity.value =
            materialInUnitModel.data!.map((data) => data.quantity!).toList();
        unitListId.value =
            materialInUnitModel.data!.map((data) => data.id).toList();

            getAvailableQuantity();
                getBin();

      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void getBin() {
    int indexCat = categoryList.indexOf(mStrcategory.trim());
    int indexMat = materialList.indexOf(mStrmaterial.trim());
    int indexUnit = unitList.indexOf(mStrUnit.trim());
    Map data = {
      'entity_id': entityId.value.toString(),
      'entity_type': entityType.value.toString(),
      'category_id': categoryListId[indexCat].toString(),
      'material_id': materialListId[indexMat].toString(),
      'unit_id': unitListId[indexUnit].toString(),
    };
    EasyLoading.show(status: t.loading);
    _api.getBin(data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialInBinModel materialInBinModel =
            MaterialInBinModel.fromJson(value);
        binList.value = materialInBinModel.data!
            .map((data) => Utils.textCapitalizationString(data.binName!))
            .toList();
        binListId.value =
            materialInBinModel.data!.map((data) => data.id).toList();
        isBin.value = true;
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void getAvailableQuantity() {
    int indexCat = categoryList.indexOf(mStrcategory.trim());
    int indexMat = materialList.indexOf(mStrmaterial.trim());
    Map data = {
      'entity_id': entityId.value.toString(),
      'entity_type': entityType.value.toString(),
      'category_id': categoryListId[indexCat].toString(),
      'material_id': materialListId[indexMat].toString(),
      'unit_id': unitListId[0].toString(),
    };
    EasyLoading.show(status: t.loading);
    _api.getQuantity(data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        isavailableQuantity.value = true;
        MaterialAvailableQuantityModel materialAvailableQuantityModel =
            MaterialAvailableQuantityModel.fromJson(value);
        availableQuantityController.value.text =
            materialAvailableQuantityModel.data.toString();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  addQuantiytToList(BuildContext context) {
    print('<><><>@@  ${mStrBin.toString()}');
    int indexCategory = categoryList.indexOf(mStrcategory.toString());
    int indexMaterial = materialList.indexOf(mStrmaterial.toString());
    if (mStrBin.isNotEmpty) {
      int indexBin = binList.indexOf(mStrBin.toString());
      mStrBinId.value = binListId[indexBin].toString();
    }

   

    Map<String, dynamic> watchList = {
      "category": Utils.textCapitalizationString(mStrcategory.value),
      "material": Utils.textCapitalizationString(mStrmaterial.value),
      "category_id": categoryListId[indexCategory].toString(),
      "material_id": materialListId[indexMaterial].toString(),
      "quantity": quantityController.value.text.toString(),
      "bin_name": Utils.textCapitalizationString(mStrBin.toString()).isEmpty ? 'NA' :  mStrBin.toString(),
      "bin_number": mStrBinId.value.toString(),
      "unit_id": unitListId[0].toString(),
      "unit_name": Utils.textCapitalizationString(unitList[0].toString()),
      "mou_name": Utils.textCapitalizationString(unitListMouName[0].toString()),
      "unit_quantity": unitListUnitQuantity[0].toString(),
      "images": image64List
          .map(
            (e) => e,
          )
          .toList(),
    };

    Map<String, dynamic> finalList = {
      "category_id": categoryListId[indexCategory].toString(),
      "material_id": materialListId[indexMaterial].toString(),
      "unit_id": unitListId[0].toString(),
      "quantity": quantityController.value.text.toString(),
      "bin_number": mStrBinId.value.toString(),
      "notes": noteController.value.text.toString(),
      "images": image64List
          .map(
            (e) => e,
          )
          .toList(),
    };
    Utils.snackBar(t.quantity, t.quantity_added_success_text);
    final materialInViewModel = Get.put(MaterialOutViewModel());
    materialInViewModel.addBinToList(watchList, finalList);
    Get.delete<QuantityOutViewModel>();
    Get.until((route) => Get.currentRoute == RouteName.materialOutScreen);
  }
}
