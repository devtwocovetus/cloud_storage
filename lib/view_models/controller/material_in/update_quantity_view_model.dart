import 'dart:developer';

import 'package:cold_storage_flutter/view_models/controller/material_in/quantity_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/material_in/update_material_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../models/material_in/material_in_bin_model.dart';
import '../../../models/material_in/material_in_category_model.dart';
import '../../../models/material_in/material_in_material_model.dart';
import '../../../models/material_in/material_in_unit_model.dart';
import '../../../repository/material_in_repository/material_in_repository.dart';
import '../../../utils/utils.dart';
import 'material_in_view_model.dart';

class UpdateQuantityViewModel extends GetxController{

  UpdateQuantityViewModel({required this.quantityIndex, required this.creationCode});
  /// When update from transaction, Creation code is 1
  final int creationCode;

  int quantityIndex;

  final _api = MaterialInRepository();
  dynamic argumentData = Get.arguments;
  var categoryList = <String>[].obs;
  var categoryListId = <int?>[].obs;
  RxString mStrQuantityId = ''.obs;

  var materialList = <String>[].obs;
  var materialListId = <int?>[].obs;

  var unitList = <String>[].obs;
  var unitListMouName = <String>[].obs;
  var unitListUnitQuantity = <int>[0].obs;
  var unitListId = <int?>[0].obs;
  var binList = <String>[].obs;
  var binListId = <int?>[].obs;

  RxString mStrcategory = 'Select Category'.obs;
  RxString mStrmaterial = 'Select Material'.obs;
  RxString mStrUnit = 'Select Unit'.obs;

  RxString mStrBin = ''.obs;
  RxString mStrBinId = ''.obs;
  RxString entityName = ''.obs;
  RxString entityId = ''.obs;

  final expirationController = TextEditingController().obs;
  final quantityController = TextEditingController().obs;
  final breakageController = TextEditingController().obs;

  final expirationCFocusNode = FocusNode().obs;
  final quantityCFocusNode = FocusNode().obs;
  final breakageCFocusNode = FocusNode().obs;

  RxList<Map<String, dynamic>> imageList = <Map<String, dynamic>>[].obs;
  RxList<String> image64List = <String>[].obs;

  RxMap<String, dynamic> entityQuantity = <String, dynamic>{}.obs;
  RxMap<String, dynamic> entityQuantityFinal = <String, dynamic>{}.obs;
  RxBool isBreakage = false.obs;

  @override
  void onInit() {
    if(argumentData!= null){
      entityName.value = argumentData['entityName'];
      entityId.value = argumentData['entityId'];
    }
    getMaterialCategorie();
    getBin(entityId.value);
    if(creationCode != 0){
      assignInitialValuesOnUpdate();
    }else{
      assignInitialValues();
    }
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
    EasyLoading.show(status: 'loading...');
    _api.getCategorie().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        String category = entityQuantity['category'];
        String categoryId = entityQuantityFinal['category_id'].toString();
        MaterialInCategoryModel materialInCategoryModel =
        MaterialInCategoryModel.fromJson(value);
        categoryList.value =
            materialInCategoryModel.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
        categoryListId.value =
            materialInCategoryModel.data!.map((data) => data.id).toList();
        if(categoryList.value.isNotEmpty){
          int index = categoryList.value.indexWhere((e) {
            return e.toLowerCase() == category.toLowerCase();
          });
          mStrcategory.value = categoryList.value[index];
          log('mStrcategory?.value 1: ${mStrcategory.value}');
          getMaterial(categoryId);
        }
        // if(categoryListId.value.isNotEmpty){
        //   int index = categoryListId.value.indexWhere((e) {
        //     return e == int.parse(categoryId);
        //   });
        //   mStrcategory.value = categoryListId.value[index];
        //   log('initialQualityType?.value 1: ${mStrcategory.value}');
        // }

      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void getMaterial(String categoryId) {
    int index = categoryList.indexOf(categoryId.toString());
    EasyLoading.show(status: 'loading...');
    _api.getMaterial(categoryListId[index].toString()).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {

      } else {
        String material = entityQuantity['material'];
        String materialId = entityQuantityFinal['material_id'].toString();
        MaterialInMaterialModel materialInMaterialModel =
        MaterialInMaterialModel.fromJson(value);
        materialList.value =
            materialInMaterialModel.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();

        materialListId.value =
            materialInMaterialModel.data!.map((data) => data.id).toList();

        if(materialList.value.isNotEmpty){
          int index = materialList.value.indexWhere((e) {
            return e.toLowerCase() == material.toLowerCase();
          });
          mStrmaterial.value = materialList.value[index];
          log('mStrcategory?.value 1: ${mStrmaterial.value}');
          getUnit(materialId);
        }
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

void getUnit(String materialId) {
    int index = materialList.indexOf(materialId.toString());
    EasyLoading.show(status: 'loading...');
    _api.getUnit(materialListId[index].toString()).then((value) {
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

      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void getBin(String entityId) {
    EasyLoading.show(status: 'loading...');
    _api.getBin(entityId).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialInBinModel materialInBinModel =
        MaterialInBinModel.fromJson(value);
        binList.value =
            materialInBinModel.data!.map((data) => Utils.textCapitalizationString(data.binName!)).toList();
        binListId.value =
            materialInBinModel.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }


  assignInitialValuesOnUpdate(){
    final materialInViewModel = Get.put(UpdateMaterialInViewModel());
    entityQuantity.value = materialInViewModel.entityQuantityList[quantityIndex];
    entityQuantityFinal.value = materialInViewModel.entityQuantityListFinal[quantityIndex];
    mStrQuantityId.value = entityQuantityFinal['id'];
    mStrBin.value = entityQuantity['bin'];
    mStrBinId.value = entityQuantityFinal['bin_number'];
    quantityController.value.text = entityQuantityFinal['quantity'];
    breakageController.value.text = entityQuantityFinal['breakage_quantity'];
    if(breakageController.value.text.isNotEmpty && breakageController.value.text != '0'){
      isBreakage.value = true;
    }
    expirationController.value.text = entityQuantity['expiry_date'];
    expirationController.value.text = entityQuantityFinal['expiry_date'];

    RxList<String> initialImage64List = List<String>.from(entityQuantity['images'].map((e) => e.toString()).toList()).obs;
    var newImage64List = initialImage64List.toList();
    log('mStrcategory?.value 11: ${newImage64List}');
    log('mStrcategory?.value 12: ${newImage64List.length}');
    for (String e in newImage64List) {
      String newBase64 = e.startsWith('data:image/png;base64,')
          ? e.substring('data:image/png;base64,'.length) : e;
      Map<String, dynamic> imageData = {
        "imgPath": null,
        "imgName": null,
        "imgBase": newBase64
      };
      addImageToList(imageData);
    }
  }

  assignInitialValues(){
    final materialInViewModel = Get.put(MaterialInViewModel());
    entityQuantity.value = materialInViewModel.entityQuantityList[quantityIndex];
    entityQuantityFinal.value = materialInViewModel.entityQuantityListFinal[quantityIndex];
    mStrBin.value = entityQuantity['bin'];
    mStrBinId.value = entityQuantityFinal['bin_number'];
    quantityController.value.text = entityQuantity['quantity'];
    quantityController.value.text = entityQuantityFinal['quantity'];
    breakageController.value.text = entityQuantity['breakage_quantity'];
    breakageController.value.text = entityQuantityFinal['breakage_quantity'];
    if(breakageController.value.text.isNotEmpty && breakageController.value.text != '0'){
      isBreakage.value = true;
    }
    expirationController.value.text = entityQuantity['expiry_date'];
    expirationController.value.text = entityQuantityFinal['expiry_date'];

    RxList<String> initialImage64List = List<String>.from(entityQuantity['images'].map((e) => e.toString()).toList()).obs;
    var newImage64List = initialImage64List.toList();
    for (String e in newImage64List) {
      String newBase64 = e.substring('data:image/png;base64,'.length);
      Map<String, dynamic> imageData = {
        "imgPath": null,
        "imgName": null,
        "imgBase": newBase64
      };
      addImageToList(imageData);
    }
  }

  addQuantiytToList(BuildContext context) {
    print('<><>@@@ ${mStrBin}');
    int indexCategory = categoryList.indexOf(mStrcategory.toString());
    int indexMaterial = materialList.indexOf(mStrmaterial.toString());
    if(mStrBin.isNotEmpty && mStrBin.value != 'NA'){
      int indexBin = binList.indexOf(mStrBin.toString());
      mStrBinId.value = binListId[indexBin].toString();
    }
    List<String> finalImage64List = <String>[];
    List newImage64List = image64List.toList();
    for (int i = 0; i < newImage64List.length; i++) {
      String isTrue = newImage64List[i].startsWith('data:image/png;base64,') ? 'true' : 'false';
      if(isTrue != 'true'){
        finalImage64List.add('data:image/png;base64,${newImage64List[i]}');
        isTrue = '';
      }else {
        finalImage64List.add(newImage64List[i]);
        isTrue = '';
      }
    }


       Map<String, dynamic> watchList = {
       "category": mStrcategory.value,
       "material": mStrmaterial.value,
       "quantity": quantityController.value.text.toString(),
       "breakage_quantity": breakageController.value.text.toString().isEmpty ? '0':breakageController.value.text.toString(),
       "bin": mStrBin.toString(),
       "expiry_date":expirationController.value.text.toString(),
       "unit_id": unitListId[0].toString(),
       "unit_name": unitList[0].toString(),
       "mou_name": unitListMouName[0].toString(),
       "unit_quantity": unitListUnitQuantity[0].toString(),
       "images": finalImage64List.map(
            (e) => e,
      )
          .toList(),
     };
 Map<String, dynamic> finalList = {
       "category_id": categoryListId[indexCategory].toString(),
       "material_id": materialListId[indexMaterial].toString(),
       "unit_id": unitListId[0].toString(),
       "quantity": quantityController.value.text.toString(),
       "breakage_quantity": breakageController.value.text.toString().isEmpty ? '0':breakageController.value.text.toString(),
       "bin_number": mStrBinId.value.toString(),
       "expiry_date":expirationController.value.text.toString(),
       "images": finalImage64List.map(
            (e) => e,
      )
          .toList(),
     };

    Utils.snackBar('Quantity', 'Quantity updated successfully');
    if(creationCode != 0){
      final materialInViewModel = Get.put(UpdateMaterialInViewModel());
      watchList.addAll({
        "id" : mStrQuantityId.value,
        "deleted" : false,
        "materialEditable": true,
        "transaction_type": materialInViewModel.transactionType.value.toLowerCase() != 'in' ? 'TRANSFERIN' : 'IN',
      });
      finalList.addAll({
        "id" : mStrQuantityId.value,
        "deleted" : false,
        "materialEditable": true,
        "transaction_type": materialInViewModel.transactionType.value.toLowerCase() != 'in' ? 'TRANSFERIN' : 'IN',
      });
      materialInViewModel.updateBinToList(quantityIndex,watchList,finalList);
      Get.delete<QuantityViewModel>();
    }else{
      watchList.addAll({
        "transaction_type": 'IN',
      });
      finalList.addAll({
        "transaction_type": 'IN',
      });
      final materialInViewModel = Get.put(MaterialInViewModel());
      materialInViewModel.updateBinToList(quantityIndex,watchList,finalList);
      Get.delete<QuantityViewModel>();
    }
    Navigator.pop(context);
  }
}