import 'package:cold_storage_flutter/models/transaction_log/transaction_log_detail_in_model.dart';
import 'package:cold_storage_flutter/models/transaction_log/transaction_log_detail_list_out_model.dart';
import 'package:cold_storage_flutter/models/transaction_log/transaction_log_detail_out_model.dart';
import 'package:cold_storage_flutter/models/transaction_log/transaction_log_detail_tr_in_model.dart';
import 'package:cold_storage_flutter/models/transaction_log/transaction_log_detail_tr_out_model.dart';
import 'package:cold_storage_flutter/repository/transaction_log_repository/transaction_log_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class TransactionLogInOutViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = TransactionLogRepository();

  RxString backOpration = ''.obs;

  RxList<TransactionDetailItemIn>? transactionLogList =
      <TransactionDetailItemIn>[].obs;
  RxList<ItemOut>? transactionLogListOut =
      <ItemOut>[].obs;

 RxList<ItemTrOut>? transactionLogListTrOut =
      <ItemTrOut>[].obs;

       RxList<ItemTrIn>? transactionLogListTrIn =
      <ItemTrIn>[].obs;


  var isLoading = true.obs;
  RxString clientName = ''.obs;
  RxString transactionType = ''.obs;
  RxString entityType = ''.obs;
  RxString transactionId = ''.obs;
  RxString transactionDate = ''.obs;
  RxString supplierClientName = ''.obs;

  RxString vendorClientName = ''.obs;
  RxString senderAccount = ''.obs;
  RxString customerClientName = ''.obs;

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

  @override
  void onInit() {
    if (argumentData != null) {
      transactionId.value = argumentData[0]['transactionId'];
      transactionDate.value = argumentData[0]['transactionDate'];
      transactionType.value = argumentData[0]['transactionType'];
      vendorClientName.value = argumentData[0]['vendorClientName'];
      senderAccount.value = argumentData[0]['senderAccount'];
      customerClientName.value = argumentData[0]['customerClientName'];
    }
    getTransactionLogDetailsList();
    super.onInit();
  }

   Future<void> transactionReturn(
      BuildContext context, String transactionDetailId,GlobalKey<FormState> formKey) async {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'transaction_detail_id': transactionDetailId.toString(),
      'transaction_type': 'RETURN_IN',//RETURN_IN
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
          getTransactionLogDetailsList();
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

  void getTransactionLogDetailsList() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.transactionsDetail(transactionId.value.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        print('<><><>@@ ${value.toString()}');
        if (transactionType.value == 'IN') {
          TransactionLogDetailInModel transactionLogDetailListModel =
              TransactionLogDetailInModel.fromJson(value);
          transactionLogList?.value =
              transactionLogDetailListModel.data!.map((data) => data).toList();
        } else if(transactionType.value == 'OUT') {
          TransactionLogDetailOutModel transactionLogDetailListModel =
              TransactionLogDetailOutModel.fromJson(value);
          transactionLogListOut?.value =
              transactionLogDetailListModel.data!.map((data) => data).toList();
        } else if(transactionType.value == 'TRANSFEROUT') {
          TransactionLogDetailTrOutModel transactionLogDetailListModel =
              TransactionLogDetailTrOutModel.fromJson(value);
          transactionLogListTrOut?.value =
              transactionLogDetailListModel.data!.map((data) => data).toList();
        } else if(transactionType.value == 'TRANSFERIN') {
          TransactionLogDetailTrInModel transactionLogDetailListModel =
              TransactionLogDetailTrInModel.fromJson(value);
          transactionLogListTrIn?.value =
              transactionLogDetailListModel.data!.map((data) => data).toList();
        }

        //TransactionLogDetailTrInModel
        //TransactionLogDetailTrOutModel
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
