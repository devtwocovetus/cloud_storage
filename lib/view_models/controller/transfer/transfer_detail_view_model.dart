import 'package:cold_storage_flutter/data/network/dio_services/api_client.dart';
import 'package:cold_storage_flutter/data/network/dio_services/api_provider/transfer_provider.dart';
import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/models/material_in/material_in_client_model.dart';
import 'package:cold_storage_flutter/models/transfer/material_transfer_detail_model.dart';
import 'package:cold_storage_flutter/repository/transfer_repository/transfer_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/controller/client/client_list_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';

class TransferDetailViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = TransferRepository();
  
  var listStatus = <bool>[].obs;
  RxList<IncomingMaterials>? incomingList = <IncomingMaterials>[].obs;
  var entityList = <String>[].obs;
  var entityListId = <int?>[].obs;
  var entityListType = <int?>[].obs;
  RxString tranferId = ''.obs;
  RxString supplierName = ''.obs;
  RxString clientName = ''.obs;
  RxString quantityCount = ''.obs;
  RxString receiptDate = ''.obs;
  RxString driverName = ''.obs;
  RxString receiverAccountName = ''.obs;
  RxString receiverAccountId = ''.obs;
  RxString note = ''.obs;
  RxString entityId = ''.obs;
  RxString entityName = ''.obs;
  RxString entityType = ''.obs;
  RxString mStrClient = ''.obs;
  RxString transactionStatusId = ''.obs;
  RxBool isConfirm = false.obs;
  RxList<Map<String, dynamic>> entityQuantityList =
      <Map<String, dynamic>>[].obs;
  RxList<String> intList = <String>[].obs;
    var clientList = <String>[].obs;
  var clientListId = <int?>[].obs;

  @override
  void onInit() {
    if (argumentData != null) {
      tranferId.value = argumentData[0]['tranferId'];
    }
    getRequestList();
    super.onInit();
  }

  addBinToList(
      Map<String, dynamic> watchList, String indexList, String mStrIndex) {
    int index = int.parse(indexList);
    if (intList.contains(mStrIndex)) {
      entityQuantityList[index] = watchList;
    } else {
      entityQuantityList.add(watchList);
      intList.add(mStrIndex);
    }
    print('<><><>....call $index');
    listStatus[index] = true;
  }

  void getEntityList() {
    EasyLoading.show(status: 'loading...');
    _api.entityListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        EntityListModel entityListModel = EntityListModel.fromJson(value);
        entityList.value = entityListModel.data!
            .map((data) => Utils.textCapitalizationString(data.name!))
            .toList();
        entityListId.value =
            entityListModel.data!.map((data) => data.id).toList();
        entityListType.value =
            entityListModel.data!.map((data) => data.entityType).toList();
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
        supplierName.value = Utils.textCapitalizationString(
            materialTransferDetailModel.data!.commonData!.supplierAccount
                .toString());
        mStrClient.value = Utils.textCapitalizationString(
            materialTransferDetailModel.data!.commonData!.supplierAccount
                .toString());
        clientName.value = Utils.textCapitalizationString(
            materialTransferDetailModel.data!.commonData!.supplierClient
                .toString());
        quantityCount.value = materialTransferDetailModel
            .data!.commonData!.incomingTotalQuantity
            .toString();
        receiptDate.value = materialTransferDetailModel
            .data!.commonData!.transactionDate
            .toString();
        driverName.value = Utils.textCapitalizationString(
            materialTransferDetailModel.data!.commonData!.driverName
                .toString());
        entityId.value =
            materialTransferDetailModel.data!.commonData!.entityId.toString();
        transactionStatusId.value = materialTransferDetailModel
            .data!.commonData!.transactionStatusId
            .toString();
        entityName.value = Utils.textCapitalizationString(
            materialTransferDetailModel.data!.commonData!.entityIdName
                .toString());
        entityType.value =
            materialTransferDetailModel.data!.commonData!.entityType.toString();
        receiverAccountName.value = Utils.textCapitalizationString(
            materialTransferDetailModel.data!.commonData!.receiverAccountName
                .toString());
        receiverAccountId.value = materialTransferDetailModel
            .data!.commonData!.receiverAccountId
            .toString();
        incomingList!.value = materialTransferDetailModel
            .data!.incomingMaterials!
            .map((data) => data)
            .toList();
        listStatus.value = materialTransferDetailModel.data!.incomingMaterials!
            .map((data) => false)
            .toList();

        getEntityList();
        getClient();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

    void getClient() {
    EasyLoading.show(status: 'loading...');
    _api.getClientList().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        print('<><><>${value.toString()}');
        print('<><><>${supplierName.value.toString()}');
        MaterialInClientModel materialInClientModel =
            MaterialInClientModel.fromJson(value);
        clientList.value = materialInClientModel.data!
            .map((data) => Utils.textCapitalizationString(data.name!))
            .toList();
        clientListId.value =
            materialInClientModel.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }



  Future<void> transferAccept(String clientId) async {
    int indexEntity = entityList.indexOf(entityName.value.toString().trim());
    int indexVendor = clientList.indexOf(mStrClient.value.toString().trim());
    EasyLoading.show(status: 'loading...');
    Map data = {
      "transaction_status_id":
          transactionStatusId.value.toString(), //from Table: transaction_status
      "accepted": 1, //1 fop accept and 2 for reject
      "entity_id": entityListId[indexEntity].toString(), //from login user api
      "entity_type":
          entityListType[indexEntity].toString(), //from login user api
      "client_id": clientListId[indexVendor], //client list for material in api
      "receiver_account_id": receiverAccountId.value.toString(),
      "transaction_detail": entityQuantityList
          .map(
            (e) => e,
          )
          .toList(),
    };
    print('<><>##call...${data.toString().trim()}');
    DioClient client = DioClient();
    final api2 = TransferProvider(client: client.init());
    api2.tranferAccept(data: data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Success', 'Material request accepted successfully');
        final entityListViewModel = Get.put(ClientListViewModel());
        entityListViewModel.getClientList();
        Get.offAndToNamed(RouteName.thankyouMaterialInClient);
        // Get.until((route) => Get.currentRoute == RouteName.entityListScreen);
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future<void> requestReject() async {
    EasyLoading.show(status: 'loading...');
    Map data = {
      'transaction_status_id': transactionStatusId.value.toString(),
      'accepted': '2'
    };
    _api.rejectRequest(data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Success', 'Material request rejected successfully');
        final entityListViewModel = Get.put(ClientListViewModel());
        entityListViewModel.getClientList();
        Get.until((route) => Get.currentRoute == RouteName.clientListScreen);
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
