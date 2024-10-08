import 'package:cold_storage_flutter/models/client/client_inventory_transactions_detail.dart';
import 'package:cold_storage_flutter/repository/client_repository/client_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/inventory/inventory_client_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/inventory/inventory_material_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/inventory/inventory_transactions_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/inventory/inventory_units_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

class ClientInventoryTransactionsDetailsViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = ClientRepository();

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

  RxString backOpration = ''.obs;
  RxString materialId = ''.obs;
  RxString materialName = ''.obs;
  RxString unitId = ''.obs;
  RxString categoryId = ''.obs;
  RxString unitName = ''.obs;
  RxString accountId = ''.obs;
  RxString accountName = ''.obs;

  RxString transactionId = ''.obs;
  RxString transactionResId = ''.obs;
  RxString transactionDate = ''.obs;
  RxString clientName = ''.obs;
  RxString transactionType = ''.obs;
  RxString isManual = ''.obs;
  RxBool isAction = false.obs;
  RxBool isTypeOfAdjustment = false.obs;

  RxList<ClientTransactionDetail>? transactionDetailsList = <ClientTransactionDetail>[].obs;
  RxList<ClientTransactionMaster>? transactionMasterList = <ClientTransactionMaster>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      transactionId.value = argumentData[0]['transactionId'];
      accountId.value = argumentData[0]['accountId'];
      accountName.value = argumentData[0]['accountName'];
      isManual.value = argumentData[0]['isManual'];
    }
    inventoryTransactionsListApi();
    super.onInit();
  }

  void inventoryTransactionsListApi() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api
        .getClientInventoryTransactionsDtails(transactionId.value.toString(),accountId.value.toString())
        .then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        ClientInventoryTransactionsDetail
            inventoryTransactionsDetailListModel =
            ClientInventoryTransactionsDetail.fromJson(value);
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
      BuildContext context, String transactionDetailId) async {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
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
        Utils.snackBar('Success', 'Transaction adjust successfully');

        inventoryTransactionsListApi();
        final inventoryClientViewModel = Get.put(InventoryClientViewModel());
        inventoryClientViewModel.inventoryClientList();
        final inventoryMaterialViewModel =
            Get.put(InventoryMaterialViewModel());
        ///Need to work on
        // inventoryMaterialViewModel
        //     .inventoryMaterialList(inventoryMaterialViewModel.clientId.value);
        final inventoryUnitsViewModel = Get.put(InventoryUnitsViewModel());
        inventoryUnitsViewModel
            .inventoryUnitsListApi(inventoryUnitsViewModel.materialId.value);
        final inventoryTransactionsViewModel =
            Get.put(InventoryTransactionsViewModel());
        inventoryTransactionsViewModel.inventoryTransactionsListApi();
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
      BuildContext context, String transactionDetailId) async {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    Map data = {
      'transaction_detail_id': transactionDetailId.toString(),
      'transaction_type': 'RETURN_OUT',
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
        ///Need to work on
        // inventoryMaterialViewModel
        //     .inventoryMaterialList(inventoryMaterialViewModel.clientId.value);
        final inventoryUnitsViewModel = Get.put(InventoryUnitsViewModel());
        inventoryUnitsViewModel
            .inventoryUnitsListApi(inventoryUnitsViewModel.materialId.value);
        final inventoryTransactionsViewModel =
            Get.put(InventoryTransactionsViewModel());
        inventoryTransactionsViewModel.inventoryTransactionsListApi();
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
