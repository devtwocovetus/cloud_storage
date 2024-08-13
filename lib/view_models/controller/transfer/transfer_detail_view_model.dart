import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/models/transfer/material_transfer_detail_model.dart';
import 'package:cold_storage_flutter/models/transfer/material_transfer_request_model.dart';
import 'package:cold_storage_flutter/repository/transfer_repository/transfer_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_prefrence_view_model.dart';

class TransferDetailViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = TransferRepository();

  RxString logoUrl = ''.obs;
  RxList<IncomingMaterials>? incomingList = <IncomingMaterials>[].obs;
  var entityList = <String>[].obs;
  var entityListId = <int?>[].obs;
  RxString tranferId = ''.obs;
  RxString supplierName = ''.obs;
  RxString clientName = ''.obs;
  RxString quantityCount = ''.obs;
  RxString receiptDate = ''.obs;
  RxString driverName = ''.obs;
  RxString note = ''.obs;
  RxString entityId = ''.obs;
  RxString entityName = ''.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      tranferId.value = argumentData[0]['tranferId'];
    }
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getRequestList();
    super.onInit();
  }

  void getEntityList() {
    EasyLoading.show(status: 'loading...');
    _api.entityListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        EntityListModel entityListModel = EntityListModel.fromJson(value);
        entityList.value =
            entityListModel.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
                entityListId.value =
            entityListModel.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void getRequestList() {
    EasyLoading.show(status: 'loading...');
    _api.getTranferIncomingDetail(tranferId.value.toString()).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialTransferDetailModel materialTransferDetailModel =
            MaterialTransferDetailModel.fromJson(value);
        supplierName.value = materialTransferDetailModel
            .data!.commonData!.supplierAccount
            .toString();
        clientName.value = materialTransferDetailModel
            .data!.commonData!.supplierClient
            .toString();
        quantityCount.value = materialTransferDetailModel
            .data!.commonData!.incomingTotalQuantity
            .toString();
        receiptDate.value = materialTransferDetailModel
            .data!.commonData!.transactionDate
            .toString();
        driverName.value =
            materialTransferDetailModel.data!.commonData!.driverName.toString();
        entityId.value =
            materialTransferDetailModel.data!.commonData!.entityId.toString();
        entityName.value = materialTransferDetailModel
            .data!.commonData!.entityIdName
            .toString();
        incomingList!.value = materialTransferDetailModel
            .data!.incomingMaterials!
            .map((data) => data)
            .toList();
            getEntityList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
