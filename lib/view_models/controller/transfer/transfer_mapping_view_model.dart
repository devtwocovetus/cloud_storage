import 'package:cold_storage_flutter/models/material_in/material_in_bin_model.dart';
import 'package:cold_storage_flutter/models/material_in/material_in_category_model.dart';
import 'package:cold_storage_flutter/models/material_in/material_in_material_model.dart';
import 'package:cold_storage_flutter/models/material_in/material_in_unit_model.dart';
import 'package:cold_storage_flutter/models/transfer/auto_mapping_model.dart';
import 'package:cold_storage_flutter/repository/transfer_repository/transfer_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/controller/transfer/transfer_detail_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';

class TransferMappingViewModel extends GetxController {
  final _api = TransferRepository();
  dynamic argumentData = Get.arguments;
  var categoryList = <String>[].obs;
  var categoryListId = <int?>[].obs;

  var materialList = <String>[].obs;
  var materialListId = <int?>[].obs;

  var unitList = <String>[].obs;
  var unitTypeList = <String>[].obs;
  var unitMouNameList = <String>[].obs;
  var unitQuantityList = <String>[].obs;
  var unitListId = <int?>[].obs;

  var binList = <String>[].obs;
  var binListId = <int?>[].obs;

  RxString mStrcategory = 'Select Category'.obs;
  RxString mStrmaterial = 'Select Material'.obs;
  RxString mStrUnit = 'Select Unit'.obs;

  RxString mStrBin = ''.obs;
  RxString mStrBinId = ''.obs;
  RxString entityName = ''.obs;
  RxString entityId = ''.obs;
  RxString clientName = ''.obs;
  RxString clientId = ''.obs;
  RxString supplierName = ''.obs;
  RxString receiverName = ''.obs;
  RxString receiverId = ''.obs;
  RxString categoryId = ''.obs;
  RxString materialName = ''.obs;
  RxString categoryName = ''.obs;
  RxString materialId = ''.obs;
  RxString unitId = ''.obs;
  RxString unitName = ''.obs;
  RxString mouName = ''.obs;
  RxString transactionDetailId = ''.obs;
  RxString transactionQuantity = ''.obs;
  RxString transactionIndex = ''.obs;

  final entityNameController = TextEditingController().obs;
  final entityNameFocusNode = FocusNode().obs;
  final clientNameController = TextEditingController().obs;
  final clientNameFocusNode = FocusNode().obs;
  final uomController = TextEditingController().obs;
  final uomFocusNode = FocusNode().obs;
  final dateController = TextEditingController().obs;
  final dateFocusNode = FocusNode().obs;
  final driverController = TextEditingController().obs;
  final driverFocusNode = FocusNode().obs;

  RxList<Map<String, dynamic>> imageList = <Map<String, dynamic>>[].obs;
  RxList<String> image64List = <String>[].obs;

  RxBool isBreakage = false.obs;
  RxBool isConfirm = false.obs;
  RxBool isCustomMapping = false.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
      clientName.value = argumentData[0]['clientName'];
      clientId.value = argumentData[0]['clientId'];
      supplierName.value = argumentData[0]['supplierName'];
      receiverName.value = argumentData[0]['receiverName'];
      materialName.value = argumentData[0]['materialName'];
      receiverId.value = argumentData[0]['receiverId'];
      categoryId.value = argumentData[0]['categoryId'];
      categoryName.value = argumentData[0]['categoryName'];
      materialId.value = argumentData[0]['materialId'];
      unitId.value = argumentData[0]['unitId'];
      unitName.value = argumentData[0]['unitName'];
      transactionDetailId.value = argumentData[0]['transactionDetailId'];
      transactionQuantity.value = argumentData[0]['quantity'];
      transactionIndex.value = argumentData[0]['index'];
      mouName.value = argumentData[0]['uom'];
    }
     print('<><><>....call ${transactionIndex.value}');
    entityNameController.value.text =
        Utils.textCapitalizationString(entityName.value.toString());
    clientNameController.value.text =
        Utils.textCapitalizationString(clientName.value.toString());
    uomController.value.text =
        Utils.textCapitalizationString(mouName.value.toString());
    getMaterialCategorie();
    getBin(entityId.value);
    super.onInit();
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
        categoryList.value = materialInCategoryModel.data!
            .map((data) => Utils.textCapitalizationString(data.name!))
            .toList();
        categoryListId.value =
            materialInCategoryModel.data!.map((data) => data.id).toList();
        //categoryList.insert(0,'Select Category');
        //categoryListId.insert(0,0);
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future<void> getMaterial(String categoryId) async {
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
        // Utils.snackBar('Error', value['message']);
        // unitList.value  = <String>['Select Unit'].obs;
        // unitListId.value = <int?>[0].obs;
        // materialList.value  = <String>['Select Material'].obs;
        //materialListId.value = <int?>[0].obs;
      } else {
        MaterialInMaterialModel materialInMaterialModel =
            MaterialInMaterialModel.fromJson(value);
        materialList.value = materialInMaterialModel.data!
            .map((data) => Utils.textCapitalizationString(data.name!))
            .toList();
        // materialList.insert(0,'Select Material');
        materialListId.value =
            materialInMaterialModel.data!.map((data) => data.id).toList();
        //materialListId.insert(0,0);

        //unitList.value  = <String>['Select Unit'].obs;
        //unitListId.value = <int?>[0].obs;
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void getUnit(String materialId) {
    print('<><><><>call.....$materialId');
    int index = materialList.indexOf(materialId.toString().trim());
    EasyLoading.show(status: 'loading...');
    _api.getUnit(materialListId[index].toString()).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialInUnitModel materialInUnitModel =
            MaterialInUnitModel.fromJson(value);
        unitList.value = materialInUnitModel.data!
            .map((data) => Utils.textCapitalizationString(data.unitName!))
            .toList();
        unitMouNameList.value = materialInUnitModel.data!
            .map((data) => Utils.textCapitalizationString(data.mouName!))
            .toList();
        unitQuantityList.value = materialInUnitModel.data!
            .map((data) =>
                Utils.textCapitalizationString(data.quantity!.toString()))
            .toList();

        unitTypeList.value = materialInUnitModel.data!
            .map((data) =>
                Utils.textCapitalizationString(data.quantityType.toString()))
            .toList();

        unitListId.value =
            materialInUnitModel.data!.map((data) => data.id).toList();

        //unitList.insert(0, 'Select Unit');
        // unitMouNameList.insert(0, 'Select Unit');
        // unitQuantityList.insert(0, 'Select Unit');
        // unitTypeList.insert(0, 'Select Unit');
        // unitListId.insert(0,0);
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
        binList.value = materialInBinModel.data!
            .map((data) => Utils.textCapitalizationString(data.binName!))
            .toList();
        binListId.value =
            materialInBinModel.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future<void> autoMappingData() async {
    EasyLoading.show(status: 'loading...');
    Map data = {
      'account_id': receiverId.value.toString(),
      'category_id': categoryId.value.toString(),
      'category_name': categoryName.value.toString(),
      'material_id': materialId.value.toString(),
      'material_name': materialName.value.toString(),
      'unit_id': unitId.value.toString(),
      'unit_name': unitName.value.toString(),
    };
    _api.autoMappingData(data).then((value) {
      
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        receiverId.value = value['data']['account_id'].toString();
        categoryId.value = value['data']['category_id'].toString();
        categoryName.value = value['data']['category_name'].toString();
        materialId.value = value['data']['material_id'].toString();
        materialName.value = value['data']['material_name'].toString();
        unitId.value = value['data']['unit_id'].toString();
        unitName.value = value['data']['unit_name'].toString();
            
        addQuantiytToList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  addQuantiytToList() {
    if (isCustomMapping.value == true) {
      int indexCategory = categoryList.indexOf(mStrcategory.toString().trim());
      int indexMaterial = materialList.indexOf(mStrmaterial.toString().trim());
      int indexUnit = unitList.indexOf(mStrUnit.toString().trim());
      categoryId.value = categoryListId[indexCategory].toString();
      materialId.value = materialListId[indexMaterial].toString();
      unitId.value = unitListId[indexUnit].toString();
    }
    if (mStrBin.isNotEmpty) {
      int indexBin = binList.indexOf(mStrBin.toString());
      mStrBinId.value = binListId[indexBin].toString();
    }
    Map<String, dynamic> watchList = {
      "transaction_status_detail_id": transactionDetailId.value.toString(),
      "quantity": transactionQuantity.value.toString(),
      "bin_number": mStrBinId.value.toString(),
      "category_id": categoryId.value.toString(),
      "material_id": materialId.value.toString(),
      "unit_id": unitId.value.toString(),
    };

    //    Map<String, dynamic> finalList = {
    //      "category_id": categoryListId[indexCategory].toString(),
    //      "material_id": materialListId[indexMaterial].toString(),
    //      "unit_id": unitListId[indexUnit].toString(),
    //      "quantity": quantityController.value.text.toString(),
    //            "breakage_quantity": breakageController.value.text.toString().isEmpty ? '0':breakageController.value.text.toString(),
    //      "bin_number": mStrBinId.value.toString(),
    //      "expiry_date":expirationController.value.text.toString(),
    //      "transaction_type": 'IN',
    //      "images": image64List.map(
    //           (e) => e,
    //         )
    //         .toList(),
    //    };
    Utils.snackBar('Success', 'Selected material mapped successfully');
    final materialInViewModel = Get.put(TransferDetailViewModel());
    materialInViewModel.addBinToList(
        watchList, transactionIndex.value.toString(),transactionDetailId.value.toString());
    Get.until((route) =>
        Get.currentRoute == RouteName.transferIncomingMaterialScreen);
  }
}
