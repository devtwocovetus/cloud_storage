import 'dart:developer';

import 'package:cold_storage_flutter/models/inventory/inventory_transactions_detail_list_model.dart';
import 'package:cold_storage_flutter/models/inventory/inventory_transactions_list_model.dart';
import 'package:cold_storage_flutter/repository/inventory_repository/inventory_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/inventory/inventory_client_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/inventory/inventory_material_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/inventory/inventory_transactions_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/inventory/inventory_units_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class InventoryTransactionsDetailsViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = InventoryRepository();

  final quantityAdjustedController = TextEditingController().obs;
  final dateAdjustedController = TextEditingController().obs;
  final reasonAdjustmentController = TextEditingController().obs;
  final commentsNotesController = TextEditingController().obs;

  final quantityAdjustedFocusNode = FocusNode().obs;
  final dateAdjustedFocusNode = FocusNode().obs;
  final reasonAdjustmentFocusNode = FocusNode().obs;
  final commentsNotesFocusNode = FocusNode().obs;

  final quantityReturnController = TextEditingController().obs;
  final dateReturnController = TextEditingController().obs;
  final reasonReturnController = TextEditingController().obs;
  final commentsNotesReturnController = TextEditingController().obs;
  final availableQuantityController = TextEditingController().obs;

  final quantityReturnFocusNode = FocusNode().obs;
  final dateReturnFocusNode = FocusNode().obs;
  final reasonReturnFocusNode = FocusNode().obs;
  final commentsNotesReturnFocusNode = FocusNode().obs;
  final availableQuantityFocusNode = FocusNode().obs;

  RxString logoUrl = ''.obs;
  RxString backOpration = ''.obs;
  RxString materialId = ''.obs;
  RxString materialName = ''.obs;
  RxString entityName = ''.obs;
  RxString entityId = ''.obs;
  RxString entityType = ''.obs;
  RxString unitId = ''.obs;
  RxString categoryId = ''.obs;
  RxString unitName = ''.obs;

  RxString transactionId = ''.obs;
  RxString transactionResId = ''.obs;
  RxString transactionDate = ''.obs;
  RxString clientName = ''.obs;
  RxString transactionType = ''.obs;
  RxBool isAction = false.obs;
  RxBool isTypeOfAdjustment = false.obs;

  RxList<TransactionDetail>? transactionDetailsList = <TransactionDetail>[].obs;
  RxList<TransactionMaster>? transactionMasterList = <TransactionMaster>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      materialId.value = argumentData[0]['materialId'];
      unitId.value = argumentData[0]['unitId'];
      transactionId.value = argumentData[0]['transactionId'];
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
      entityType.value = argumentData[0]['entityType'];
    }
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    inventoryTransactionsListApi();
    super.onInit();
  }

  void inventoryTransactionsListApi() {
    print('inventoryTransactionsDetailListModel My data value');
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api
        .inventoryTransactionsDetailListApi(transactionId.value.toString(),
            entityId.value.toString(), entityType.value.toString())
        .then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      print('inventoryTransactionsDetailListModel My data value22');
      log('inventoryTransactionsDetailListModel My data 1 : ${value}');
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        InventoryTransactionsDetailListModel
            inventoryTransactionsDetailListModel =
            InventoryTransactionsDetailListModel.fromJson(value);
        log('inventoryTransactionsDetailListModel My data : ${inventoryTransactionsDetailListModel.toJson()}');
        transactionDetailsList?.value = inventoryTransactionsDetailListModel
            .data!.transactionDetail!
            .map((data) => data)
            .toList();

        transactionMasterList?.value = inventoryTransactionsDetailListModel
            .data!.transactionMaster!
            .map((data) => data)
            .toList();
        if (transactionMasterList!.isNotEmpty) {
          transactionResId.value = Utils.textCapitalizationString(
              transactionMasterList![0].id.toString());
          transactionDate.value = Utils.textCapitalizationString(
              transactionMasterList![0].transactionDate.toString());
          clientName.value = Utils.textCapitalizationString(
              transactionMasterList![0].clientName.toString());
          transactionType.value = Utils.textCapitalizationString(
              transactionMasterList![0].transactionType.toString());
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future<void> transactionAdjust(
      BuildContext context, String transactionDetailId,GlobalKey<FormState> formKey) async {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'transaction_detail_id': transactionDetailId.toString(),
      'transaction_type': isTypeOfAdjustment.value ? 'ADJ+' : 'ADJ-',
      'quantity': quantityAdjustedController.value.text.toString(),
      'adjust_date': dateAdjustedController.value.text.toString(),
      'reason': reasonAdjustmentController.value.text.toString(),
      'notes': commentsNotesController.value.text.toString(),
    };
    _api.transactionsAdjust(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Success', 'Transaction adjusted successfully');

        inventoryTransactionsListApi();
        final inventoryClientViewModel = Get.put(InventoryClientViewModel());
        inventoryClientViewModel.inventoryClientList();
        final inventoryMaterialViewModel =
            Get.put(InventoryMaterialViewModel());
        inventoryMaterialViewModel
            .inventoryMaterialList();
        // final inventoryUnitsViewModel = Get.put(InventoryUnitsViewModel());
        // inventoryUnitsViewModel
        //     .inventoryUnitsListApi(inventoryUnitsViewModel.materialId.value);
        final inventoryTransactionsViewModel =
            Get.put(InventoryTransactionsViewModel());
        inventoryTransactionsViewModel.inventoryTransactionsListApi();
        formKey.currentState!.reset();
        Navigator.pop(context);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.isCheck = true;
      Utils.snackBar('Error', error.toString());
    });
  }

  Future<void> transactionReturn(
      BuildContext context, String transactionDetailId,GlobalKey<FormState> formKey) async {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'transaction_detail_id': transactionDetailId.toString(),
      'transaction_type': 'RETURN_OUT',//RETURN_IN
      'quantity': quantityReturnController.value.text.toString(),
      'return_date': dateReturnController.value.text.toString(),
      'reason': reasonReturnController.value.text.toString(),
      'notes': commentsNotesReturnController.value.text.toString(),
    };
    _api.transactionsReturn(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Success', 'Transaction return successfully');
       
        inventoryTransactionsListApi();
        final inventoryClientViewModel = Get.put(InventoryClientViewModel());
        inventoryClientViewModel.inventoryClientList();
        final inventoryMaterialViewModel =
            Get.put(InventoryMaterialViewModel());
        inventoryMaterialViewModel
            .inventoryMaterialList();
        // final inventoryUnitsViewModel = Get.put(InventoryUnitsViewModel());
        // inventoryUnitsViewModel
        //     .inventoryUnitsListApi(inventoryUnitsViewModel.materialId.value);
        final inventoryTransactionsViewModel =
            Get.put(InventoryTransactionsViewModel());
        inventoryTransactionsViewModel.inventoryTransactionsListApi();
        formKey.currentState!.reset();
        Navigator.pop(context);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.isCheck = true;
      Utils.snackBar('Error', error.toString());
    });
  }
}
