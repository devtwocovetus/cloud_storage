import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cold_storage_flutter/data/network/dio_services/api_client.dart';
import 'package:cold_storage_flutter/data/network/dio_services/api_provider/material_provider.dart';
import 'package:cold_storage_flutter/extensions/extension.dart';
import 'package:cold_storage_flutter/models/inventory/inventory_transactions_detail_list_model.dart';
import 'package:cold_storage_flutter/models/material_in/material_in_client_model.dart';
import 'package:cold_storage_flutter/repository/material_in_repository/material_in_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/utils.dart';

class UpdateMaterialInViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = MaterialInRepository();

  var clientList = <String>[].obs;
  var clientListId = <int?>[].obs;
  RxString mStrClient = ''.obs;

  final entityNameController = TextEditingController().obs;
  final entityNameFocusNode = FocusNode().obs;

  final dateController = TextEditingController().obs;
  final dateFocusNode = FocusNode().obs;
  final driverController = TextEditingController().obs;
  final driverFocusNode = FocusNode().obs;

  RxList<Map<String, dynamic>> entityQuantityList =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> entityQuantityListFinal =
      <Map<String, dynamic>>[].obs;
  RxString entityName = ''.obs;
  RxString entityId = ''.obs;
  RxString unitId = ''.obs;
  RxString entityType = ''.obs;
  RxString transactionId = ''.obs;
  RxString transactionMasterId = ''.obs;
  RxString transactionDateReceipt = ''.obs;
  RxString clientName = ''.obs;
  RxString clientId = ''.obs;
  RxString transactionType = ''.obs;
  RxString signatureFilePath = ''.obs;
  RxString signatureBase64 = ''.obs;
  RxBool isConfirm = false.obs;

  RxList<TransactionDetail>? transactionDetailsList = <TransactionDetail>[].obs;
  RxList<TransactionMaster>? transactionMasterList = <TransactionMaster>[].obs;

  @override
  Future<void> onInit() async {
    if (argumentData != null) {
      unitId.value = argumentData[0]['unitId'];
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
      entityType.value = argumentData[0]['entityType'];
      transactionId.value = argumentData[0]['transactionId'];
    }
    entityNameController.value.text = entityName.value.toCapitalize();
    await inventoryTransactionsListApi();
    getClient();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    if(EasyLoading.isShow){
      EasyLoading.dismiss();
    }
    super.onReady();
  }


  Future<void> imageBase64Convert(File? image) async {
    if (image == null) {
    } else {
      signatureFilePath.value = image.path.toString();
      final bytes = File(image.path).readAsBytesSync();
      signatureBase64.value = "data:image/png;base64,${base64Encode(bytes)}";
    }
  }

  Future<void> inventoryTransactionsListApi() async {
    EasyLoading.show(status: 'loading...');
    _api
        .inventoryTransactionsDetailListApi(transactionId.value.toString(),
            entityId.value.toString(), entityType.value.toString())
        .then((value) async {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        InventoryTransactionsDetailListModel
            inventoryTransactionsDetailListModel =
            InventoryTransactionsDetailListModel.fromJson(value);
        transactionDetailsList?.value = inventoryTransactionsDetailListModel
            .data!.transactionDetail!
            .map((data) => data)
            .toList();

        transactionMasterList?.value = inventoryTransactionsDetailListModel
            .data!.transactionMaster!
            .map((data) => data)
            .toList();
        if (transactionMasterList!.isNotEmpty) {
          transactionMasterId.value = Utils.textCapitalizationString(
              transactionMasterList![0].id.toString());
          transactionDateReceipt.value = Utils.textCapitalizationString(
              transactionMasterList![0].transactionDate.toString());
          clientName.value = Utils.textCapitalizationString(
              transactionMasterList![0].clientName.toString());
          clientId.value = Utils.textCapitalizationString(
              transactionMasterList![0].clientId.toString());
          transactionType.value = Utils.textCapitalizationString(
              transactionMasterList![0].transactionType.toString());
          mStrClient.value = clientName.value;
          dateController.value.text = transactionDateReceipt.value;
        }
        EasyLoading.show(status: 'loading...');

        for (TransactionDetail transactionDetail in transactionDetailsList!) {
          List<String> images64 =  transactionDetail.images.toString().isNotEmpty ? await getImage64List(transactionDetail.images.toString()) : [];

          Map<String, dynamic> finalList = {
            "category_id": transactionDetail.categoryId.toString(),
            "material_id": transactionDetail.materialId.toString(),
            "unit_id": transactionDetail.unitId.toString(),
            "quantity": transactionDetail.totalReceived.toString(),
            "breakage_quantity": transactionDetail.breakageQuantity.toString(),
            "bin_number": transactionDetail.binNumber.toString(),
            "expiry_date": transactionDetail.expiryDate.toString(),
            "transaction_type": 'IN',
            "images": images64,
            "materialEditable": transactionDetail.materialEditable.toString(),
          };

          // Map<String, dynamic> watchList = {
          //   "category": transactionDetail.categoryName.toString(),
          //   "material": transactionDetail.materialName.toString(),
          //   "unit": transactionDetail.unitName.toString(),
          //   "quantity": transactionDetail.totalReceived.toString(),
          //   "breakage_quantity": transactionDetail.breakageQuantity.toString(),
          //   "bin": transactionDetail.binName.toString(),
          //   "expiry_date": transactionDetail.expiryDate.toString(),
          //   "transaction_type": 'IN',
          //   "unit_type": transactionDetail.quantityTypeName.toString(),
          //   "unit_quantity": transactionDetail.unitQuantity.toString(),
          //   "mou_name": transactionDetail.mouName.toString(),
          //   "images": images64,
          // };

          Map<String, dynamic> watchList = {
            "category": transactionDetail.categoryName.toString(),
            "material": transactionDetail.materialName.toString(),
            "quantity": transactionDetail.totalReceived.toString(),
            "breakage_quantity": transactionDetail.breakageQuantity.toString().isEmpty ? '0':transactionDetail.breakageQuantity.toString(),
            "bin": transactionDetail.binName.toString(),
            "expiry_date":transactionDetail.expiryDate.toString(),
            "transaction_type": 'IN',
            "unit_id": transactionDetail.unitId.toString(),
            "unit_name": transactionDetail.unitName.toString(),
            "mou_name": transactionDetail.mouName.toString(),
            "unit_quantity": transactionDetail.unitQuantity.toString(),
            "images": images64,
            "materialEditable": transactionDetail.materialEditable.toString(),
          };
      entityQuantityList.add(watchList);
          entityQuantityListFinal.add(finalList);
        }
        EasyLoading.dismiss();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
    EasyLoading.dismiss();
  }

  void getClient() {
    print('entityQuantityListFinal : 1 : Iamhere');
    EasyLoading.show(status: 'loading...');
    _api.getClient().then((value) {
      EasyLoading.dismiss();
      print('entityQuantityListFinal : 1 : Iamhere $value');
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialInClientModel materialInClientModel =
            MaterialInClientModel.fromJson(value);
        clientList.value = materialInClientModel.data!
            .map((data) => Utils.textCapitalizationString(data.name!))
            .toList();
        clientListId.value =
            materialInClientModel.data!.map((data) => data.id).toList();
        log('entityQuantityListFinal : 123 ${mStrClient.value.toString()}');
        log('entityQuantityListFinal : 124 ${clientName.value.toString()}');
        mStrClient.value = clientName.value;
        log('entityQuantityListFinal : 111 ${clientListId.toString()}');
        log('entityQuantityListFinal : 122 ${clientList.toString()}');
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  addBinToList(Map<String, dynamic> watchList, Map<String, dynamic> finalList) {
    entityQuantityList.add(watchList);
    entityQuantityListFinal.add(finalList);
  }

  updateBinToList(int index, Map<String, dynamic> watchList,
      Map<String, dynamic> finalList) {
    entityQuantityList[index] = watchList;
    entityQuantityListFinal[index] = finalList;
  }

  deleteBinToList(int index) {
    entityQuantityList.removeAt(index);
    entityQuantityListFinal.removeAt(index);
  }

  Future<void> updateMaterialIn() async {
    int indexClient = clientList.indexOf(Utils.textCapitalizationString(mStrClient.value.toString()));
    EasyLoading.show(status: 'loading...');
    log('entityQuantityListFinal : 11 ${clientListId.toString()}');
    log('entityQuantityListFinal : 12 ${clientList.toString()}');
    log('entityQuantityListFinal : 13 ${entityQuantityListFinal.toString()}');
    Map data = {
      'entity_id': entityId.value.toString(),
      'entity_type': entityType.value.toString(),
      'client_id': clientListId[indexClient].toString(),
      'transaction_date': dateController.value.text,
      'transaction_type': 'IN',
      'status': '1',
      'driver_name': Utils.textCapitalizationString(driverController.value.text),
      'signature': signatureBase64.value.toString(),
      'transaction_details': entityQuantityListFinal
          .map(
            (e) => e,
          )
          .toList(),
    };
    DioClient client = DioClient();
    final api2 = MaterialProvider(client: client.init());
    api2.addMaterialIn(data: data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        Get.offNamed(RouteName.materialInThankyou,arguments: {
          'code' : 1
        });
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  String? listToString(List<String>? urlList) {
    // Convert list of strings to one single string including its brackets and double quotation marks
    if (urlList == null || urlList.isEmpty) {
      return '';
    }
    final buffer = StringBuffer();
    for (int i = 0; i < urlList.length; i++) {
      buffer.write(urlList[i]);
      if (i < urlList.length - 1) {
        buffer.write(',');
      }
    }
    // buffer.write();
    return buffer.toString();
  }

  Future<List<String>> getImage64List(String img) async {
    List<String> image64List = <String>[];
    List b = (img.split(','));
    for (String url in b) {
      String base64 = await networkImageToBase64(url.trim());
      image64List.add(base64);
    }
    return image64List;
  }

  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl.trim()));
    final bytes = response.bodyBytes;
    return base64Encode(bytes);
  }
}
