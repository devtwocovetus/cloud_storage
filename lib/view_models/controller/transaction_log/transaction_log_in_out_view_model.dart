// Importing necessary packages and models used in this ViewModel
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

import '../../../i10n/strings.g.dart';

// ViewModel class for managing transaction logs (IN/OUT/TRANSFER)
class TransactionLogInOutViewModel extends GetxController {
  // Arguments passed to this view model via Get
  dynamic argumentData = Get.arguments;

  // API repository for making transaction log requests
  final _api = TransactionLogRepository();

  // Observables for managing state
  RxString backOpration = ''.obs;

  // Observable lists for holding transaction details based on different transaction types
  RxList<TransactionDetailItemIn>? transactionLogList = <TransactionDetailItemIn>[].obs;
  RxList<ItemOut>? transactionLogListOut = <ItemOut>[].obs;
  RxList<ItemTrOut>? transactionLogListTrOut = <ItemTrOut>[].obs;
  RxList<ItemTrIn>? transactionLogListTrIn = <ItemTrIn>[].obs;

  // Observable for loading state
  var isLoading = true.obs;

  // Observables for holding transaction-related data
  RxString clientName = ''.obs;
  RxString transactionType = ''.obs;
  RxString entityType = ''.obs;
  RxString transactionId = ''.obs;
  RxString transactionDate = ''.obs;
  RxString supplierClientName = ''.obs;
  RxString vendorClientName = ''.obs;
  RxString senderAccount = ''.obs;
  RxString customerClientName = ''.obs;
  RxString comeFrom = ''.obs;

  // Controllers and FocusNodes for managing input fields in the return transaction form
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

  // Called when the ViewModel is initialized
  @override
  void onInit() {
    // If argument data is passed, populate the transaction data
    if (argumentData != null) {
      transactionId.value = argumentData[0]['transactionId'];
      transactionDate.value = argumentData[0]['transactionDate'];
      transactionType.value = argumentData[0]['transactionType'];
      vendorClientName.value = argumentData[0]['vendorClientName'];
      senderAccount.value = argumentData[0]['senderAccount'];
      customerClientName.value = argumentData[0]['customerClientName'];
      comeFrom.value = argumentData[0]['from'];
    }

    // Fetch the transaction log details based on the transaction ID
    getTransactionLogDetailsList();
    super.onInit();
  }

  // Function to handle transaction return logic
  Future<void> transactionReturn(
    BuildContext context, String transactionDetailId, GlobalKey<FormState> formKey) async {

    // Start loading and show a loading indicator
    isLoading.value = true;
    EasyLoading.show(status: t.loading);

    // Prepare the data to be sent for the return transaction
    Map data = {
      'transaction_detail_id': transactionDetailId.toString(),
      'transaction_type': 'RETURN_IN',  // Type of return transaction
      'quantity': quantityReturnController.value.text.toString(),
      'return_date': dateReturnController.value.text.toString(),
      'reason': reasonReturnController.value.text.toString(),
      'notes': commentsNotesReturnController.value.text.toString(),
    };

    // Make API call for returning a transaction
    _api.transactionsReturn(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();  // Hide loading indicator

      // If API call is successful
      if (value['status'] == 1) {
        Utils.isCheck = true;
        Utils.snackBar(t.success_text, t.transaction_return_success_text);

        // Refresh the transaction log details list and reset the form
        getTransactionLogDetailsList();
        formKey.currentState!.reset();
        Navigator.pop(context);
      } else {
        // If there was an error
        // Utils.snackBar('Error', value['message']);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.isCheck = true;
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  // Function to fetch transaction log details list based on the transaction type
  void getTransactionLogDetailsList() {
    isLoading.value = true;  // Show loading
    EasyLoading.show(status: t.loading);

    // Make API call to fetch transaction details
    _api.transactionsDetail(transactionId.value.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();  // Hide loading

      // If the API call is successful
      if (value['status'] == 1) {
        // Print the response for debugging purposes
        print('<><><>@@ ${value.toString()}');

        // Populate the correct transaction list based on the transaction type
        if (transactionType.value == 'IN') {
          TransactionLogDetailInModel transactionLogDetailListModel = TransactionLogDetailInModel.fromJson(value);
          transactionLogList?.value = transactionLogDetailListModel.data!.map((data) => data).toList();
        } else if (transactionType.value == 'OUT') {
          TransactionLogDetailOutModel transactionLogDetailListModel = TransactionLogDetailOutModel.fromJson(value);
          transactionLogListOut?.value = transactionLogDetailListModel.data!.map((data) => data).toList();
        } else if (transactionType.value == 'TRANSFEROUT') {
          TransactionLogDetailTrOutModel transactionLogDetailListModel = TransactionLogDetailTrOutModel.fromJson(value);
          transactionLogListTrOut?.value = transactionLogDetailListModel.data!.map((data) => data).toList();
        } else if (transactionType.value == 'TRANSFERIN') {
          TransactionLogDetailTrInModel transactionLogDetailListModel = TransactionLogDetailTrInModel.fromJson(value);
          transactionLogListTrIn?.value = transactionLogDetailListModel.data!.map((data) => data).toList();
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }
}
