import 'package:cold_storage_flutter/models/material_in/material_in_bin_model.dart';
import 'package:cold_storage_flutter/models/material_in/material_in_category_model.dart';
import 'package:cold_storage_flutter/models/material_in/material_in_material_model.dart';
import 'package:cold_storage_flutter/models/material_in/material_in_unit_model.dart';
import 'package:cold_storage_flutter/repository/material_in_repository/material_in_repository.dart';
import 'package:cold_storage_flutter/view_models/controller/material_in/material_in_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';

class QuantityViewModel extends GetxController {
  final _api = MaterialInRepository();
   dynamic argumentData = Get.arguments;
  var categoryList = <String>[].obs;
  var categoryListId = <int?>[].obs;

  var materialList = <String>[].obs;
  var materialListId = <int?>[].obs;

  var unitList = <String>[].obs;
  var unitTypeList = <String>[].obs;
  var unitMouNameList = <String>[].obs;
  var unitQuantityList = <String>[].obs;
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

  RxList<Map<String, dynamic>> imageList = <Map<String, dynamic>>[].obs;
  RxList<String> image64List = <String>[].obs;

  RxBool isBreakage = false.obs;

  @override
  void onInit() {
     if(argumentData!= null){
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
    }
    getMaterialCategorie();
    getBin(entityId.value);
    super.onInit();
  }

  addImageToList(Map<String, dynamic> img) {
    imageList.add(img);
    image64List.add(img['imgBase']);
  }

  void getMaterialCategorie() {
    EasyLoading.show(status: 'loading...');
    _api.getCategorie().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialInCategoryModel materialInCategoryModel =
            MaterialInCategoryModel.fromJson(value);
        categoryList.value =
            materialInCategoryModel.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
        categoryListId.value =
            materialInCategoryModel.data!.map((data) => data.id).toList();
            

      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void getMaterial(String categoryId) {
     unitList.value = <String>[].obs;
   unitTypeList.value = <String>[].obs;
   unitMouNameList.value = <String>[].obs;
   unitQuantityList.value = <String>[].obs;
   unitListId.value = <int?>[].obs;
     int index = categoryList.indexOf(categoryId.toString());
    EasyLoading.show(status: 'loading...');
    _api.getMaterial(categoryListId[index].toString()).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        
      } else {
        MaterialInMaterialModel materialInMaterialModel =
            MaterialInMaterialModel.fromJson(value);
        materialList.value =
            materialInMaterialModel.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
          
        materialListId.value =
            materialInMaterialModel.data!.map((data) => data.id).toList();
            
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
             unitMouNameList.value =
            materialInUnitModel.data!.map((data) => Utils.textCapitalizationString(data.mouName!)).toList();
             unitQuantityList.value =
            materialInUnitModel.data!.map((data) => Utils.textCapitalizationString(data.quantity!.toString())).toList();

            unitTypeList.value =
            materialInUnitModel.data!.map((data) => Utils.textCapitalizationString(data.quantityType.toString())).toList();
            
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

   addQuantiytToList(BuildContext context) {
     int indexCategory = categoryList.indexOf(mStrcategory.toString());
     int indexMaterial = materialList.indexOf(mStrmaterial.toString());
     int indexUnit = unitList.indexOf(mStrUnit.toString());
     if(mStrBin.isNotEmpty){
     int indexBin = binList.indexOf(mStrBin.toString());
     mStrBinId.value = binListId[indexBin].toString();
     }
     

     Map<String, dynamic> watchList = {
       "category": mStrcategory.value,
       "material": mStrmaterial.value,
       "unit": mStrUnit.value,
       "quantity": quantityController.value.text.toString(),
       "breakage_quantity": breakageController.value.text.toString().isEmpty ? '0':breakageController.value.text.toString(),
       "bin": mStrBin.toString(),
       "expiry_date":expirationController.value.text.toString(),
       "transaction_type": 'IN',
       "unit_type": unitTypeList[indexUnit].toString(),
       "unit_quantity": unitQuantityList[indexUnit].toString(),
       "mou_name": unitMouNameList[indexUnit].toString(),
       "images": image64List.map(
            (e) => e,
          )
          .toList(),
     };

     Map<String, dynamic> finalList = {
       "category_id": categoryListId[indexCategory].toString(),
       "material_id": materialListId[indexMaterial].toString(),
       "unit_id": unitListId[indexUnit].toString(),
       "quantity": quantityController.value.text.toString(),
             "breakage_quantity": breakageController.value.text.toString().isEmpty ? '0':breakageController.value.text.toString(),
       "bin_number": mStrBinId.value.toString(),
       "expiry_date":expirationController.value.text.toString(),
       "transaction_type": 'IN',
       "images": image64List.map(
            (e) => e,
          )
          .toList(),
     };
     Utils.snackBar('Quantity', 'Quantity Added Successfully');
     final materialInViewModel = Get.put(MaterialInViewModel());
     materialInViewModel.addBinToList(watchList,finalList);
     Get.delete<QuantityViewModel>();
     Navigator.pop(context);
   }
}
