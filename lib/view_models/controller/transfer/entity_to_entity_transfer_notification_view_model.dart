import 'package:cold_storage_flutter/models/transfer/entity_to_entity_transfer_notification.dart';
import 'package:cold_storage_flutter/models/transfer/material_transfer_request_model.dart';
import 'package:cold_storage_flutter/repository/transfer_repository/transfer_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';

class EntityToEntityTransferNotificationViewModel extends GetxController {
 dynamic argumentData = Get.arguments;
 final _api = TransferRepository();

 RxList<InternalRequest>? incomingRequestList = <InternalRequest>[].obs;
 RxString entityId = ''.obs;
 RxString entityType = ''.obs;

  @override
  void onInit() {
     if (argumentData != null) {
       entityId.value = argumentData[0]['entityId'];
       entityType.value = argumentData[0]['entityType'];
     }
    getRequestList();
    super.onInit();
  }

  void getRequestList() {
    EasyLoading.show(status: 'loading...');
    _api.internalTransferNotificationsList(entityId.value.toString(),entityType.value).then((value) {
      print('<><><>@@@ ${value.toString()}');
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
         EntityToEntityTransferNotification materialTransferRequestModel =
             EntityToEntityTransferNotification.fromJson(value);
        incomingRequestList!.value =
             materialTransferRequestModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
