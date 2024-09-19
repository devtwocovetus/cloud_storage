import 'package:cold_storage_flutter/models/transaction_log/transaction_log_list_model.dart';
import 'package:cold_storage_flutter/repository/transaction_log_repository/transaction_log_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class TransactionLogListViewModel extends GetxController {
    dynamic argumentData = Get.arguments;
  final _api = TransactionLogRepository();

  RxString backOpration = ''.obs;

  RxList<TransactionLogItem>? transactionLogList = <TransactionLogItem>[].obs;
  var isLoading = true.obs;
  RxString entityName = ''.obs;
  RxString entityId = ''.obs;
  RxString entityType = ''.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
      entityType.value = argumentData[0]['entityType'];
    }
    getTransactionLogList();
    super.onInit();
  }

   
  void getTransactionLogList() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.transactionClientListApi(entityId.value.toString(),entityType.value.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        TransactionLogListModel transactionLogListModel = TransactionLogListModel.fromJson(value);
        transactionLogList?.value = transactionLogListModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
