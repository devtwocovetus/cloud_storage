import 'package:cold_storage_flutter/models/transfer/material_transfer_request_model.dart';
import 'package:cold_storage_flutter/repository/transfer_repository/transfer_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_prefrence_view_model.dart';

class TransferNotificationViewModel extends GetxController {
 dynamic argumentData = Get.arguments;
 final _api = TransferRepository();

 RxString logoUrl = ''.obs;
 RxList<IncomingRequest>? incomingRequestList = <IncomingRequest>[].obs;
 RxString clientId = ''.obs;

  @override
  void onInit() {
     if (argumentData != null) {
       clientId.value = argumentData[0]['clientId'];
     }
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getRequestList();
    super.onInit();
  }

  void getRequestList() {
    EasyLoading.show(status: 'loading...');
    _api.getTranferIncomingRequest(clientId.value.toString()).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialTransferRequestModel materialTransferRequestModel =
            MaterialTransferRequestModel.fromJson(value);
        incomingRequestList!.value =
            materialTransferRequestModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
