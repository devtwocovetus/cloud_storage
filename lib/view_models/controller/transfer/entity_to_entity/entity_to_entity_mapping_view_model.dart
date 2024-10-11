import 'package:cold_storage_flutter/data/network/dio_services/api_client.dart';
import 'package:cold_storage_flutter/data/network/dio_services/api_provider/transfer_provider.dart';
import 'package:cold_storage_flutter/models/material_in/material_in_bin_model.dart';
import 'package:cold_storage_flutter/repository/transfer_repository/transfer_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/entity_transfer/entity_list_for_transfer_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../i10n/strings.g.dart';

class EntityToEntityMappingViewModel extends GetxController {
  final _api = TransferRepository();
  dynamic argumentData = Get.arguments;

  var binList = <String>[].obs;
  var binListId = <int?>[].obs;

  RxString mStrBin = ''.obs;
  RxString mStrBinId = ''.obs;

  RxInt quantity = 0.obs;
  RxString materialName = ''.obs;
  RxString mouName = ''.obs;
  RxString senderEntity = ''.obs;
  RxString receiverEntity = ''.obs;
  RxString notificationId = ''.obs;
  RxString comeFrom = ''.obs;
  RxInt fromEntityId = 0.obs;
  RxInt toEntityId = 0.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      notificationId.value = argumentData[0]['notificationId'];
      comeFrom.value = argumentData[0]['from'];
    }
    getDetails();
    super.onInit();
  }

  void getDetails() {
    EasyLoading.show(status: t.loading);
    _api.getTransferDetails(notificationId.value).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        materialName.value = value['data']['material_name'];
        mouName.value = value['data']['mou_name'];
        senderEntity.value = value['data']['sender_entity'];
        receiverEntity.value = value['data']['receiver_entity'];
        fromEntityId.value = value['data']['from_entity_id'];
        toEntityId.value = value['data']['to_entity_id'];
        quantity.value = value['data']['quantity'];

        getBin(toEntityId.value.toString());
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void getBin(String entityId) {
    EasyLoading.show(status: t.loading);
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
      Utils.snackBar(t.error_text, error.toString());
    });
  }


  Future<void> transferAccept(String op) async {
    EasyLoading.show(status: t.loading);
    Map data = {'transfer_id': notificationId.value.toString(), 'accepted': op};
    print('<><>##call...${data.toString().trim()}');
    DioClient client = DioClient();
    final api2 = TransferProvider(client: client.init());
    api2.tranferAcceptInternal(data: data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {

        if (op == '1') {
          Get.toNamed(RouteName.entityToEntityThankyouMaterialIn,
              arguments: [
           {"from": comeFrom.value}
         ]);
        } else {
          Utils.isCheck = true;
          Utils.snackBar(t.reject, t.material_transfer_rejected_text);
          if(comeFrom.value == 'Normal'){
  EntityListForTransferViewModel v =
              Get.put(EntityListForTransferViewModel());
          v.getEntityList();
          Get.until((route) =>
              Get.currentRoute == RouteName.entityListForTransferScreen);
          }else {
            Get.offAllNamed(RouteName.homeScreenView,
                                arguments: []);
          }
        
        }
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

 

}
