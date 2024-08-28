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
import '../user_preference/user_prefrence_view_model.dart';

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

  RxString logoUrl = ''.obs;
  RxList<Map<String, dynamic>> entityQuantityList =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> entityQuantityListFinal =
      <Map<String, dynamic>>[].obs;
  RxString entityName = ''.obs;
  RxString entityId = ''.obs;
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
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
      entityType.value = argumentData[0]['entityType'];
      transactionId.value = argumentData[0]['transactionId'];
    }
    entityNameController.value.text = entityName.value.toCapitalize();
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    await inventoryTransactionsListApi();
    getClient();

    super.onInit();
  }

  Future<void> imageBase64Convert(File? image) async {
    print('<><><><>  ${image!.path.toString()}');
    if (image == null) {
    } else {
      signatureFilePath.value = image.path.toString();
      final bytes = File(image!.path).readAsBytesSync();
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
              mStrClient.value =  clientName.value;
              dateController.value.text = transactionDateReceipt.value;
        }

        for (TransactionDetail transactionDetail in transactionDetailsList!) {
          Map<String, dynamic> finalList = {
            "category_id": transactionDetail.categoryId.toString(),
            "material_id": transactionDetail.materialId.toString(),
            "unit_id": transactionDetail.unitId.toString(),
            "quantity": transactionDetail.totalReceived.toString(),
            "breakage_quantity": transactionDetail.breakageQuantity.toString(),
            "bin_number": transactionDetail.binNumber.toString(),
            "expiry_date": transactionDetail.expiryDate.toString(),
            "transaction_type": 'IN',
            "images": getImage64List(transactionDetail.images.toString())
                .map(
                  (e) => e,
                )
                .toList(),
          };
   
          Map<String, dynamic> watchList = {
       "category": transactionDetail.categoryName.toString(),
       "material": transactionDetail.materialName.toString(),
       "unit": transactionDetail.unitName.toString(),
       "quantity": transactionDetail.totalReceived.toString(),
       "breakage_quantity": transactionDetail.breakageQuantity.toString(),
       "bin": transactionDetail.binName.toString(),
       "expiry_date":transactionDetail.expiryDate.toString(),
       "transaction_type": 'IN',
       "unit_type": transactionDetail.quantityTypeName.toString(),
       "unit_quantity": transactionDetail.unitQuantity.toString(),
       "mou_name": transactionDetail.mouName.toString(),
       "images": getImage64List(transactionDetail.images.toString())
                .map(
                  (e) => e,
                )
                .toList(),
     };
          entityQuantityList.add(watchList);
          entityQuantityListFinal.add(finalList);
        }
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void getClient() {
    EasyLoading.show(status: 'loading...');
    _api.getClient().then((value) {
      EasyLoading.dismiss();
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
        mStrClient.value = clientName.value;
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  addBinToList(Map<String, dynamic> watchList, Map<String, dynamic> finalList) {
    entityQuantityList.add(watchList);
    entityQuantityListFinal.add(finalList);
    log("entityBinList : ${jsonEncode(entityQuantityList)}");
  }

  deleteBinToList(int index) {
    entityQuantityList.removeAt(index);
    entityQuantityListFinal.removeAt(index);
    log("entityBinList : ${jsonEncode(entityQuantityList)}");
  }

  Future<void> addMaterialIn() async {
    int indexClient = clientList.indexOf(mStrClient.value.toString());
    EasyLoading.show(status: 'loading...');
    Map data = {
      'entity_id': entityId.value.toString(),
      'entity_type': entityType.value.toString(),
      'client_id': clientListId[indexClient].toString(),
      'transaction_date': dateController.value.text,
      'transaction_type': 'IN',
      'status': '1',
      'driver_name': driverController.value.text,
      'signature': signatureBase64.value.toString(),
      'transaction_details': entityQuantityListFinal
          .map(
            (e) => e,
          )
          .toList(),
    };
    printWrapped('<><><>#### ${data.toString()}');
    log('DataMap : ${data.toString()}');
    DioClient client = DioClient();
    final api2 = MaterialProvider(client: client.init());
    api2.addMaterialIn(data: data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        log('ResP1 ${value['message']}');
      } else {
        log('ResP2 ${value['message']}');
        Get.offNamed(RouteName.materialInThankyou);
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
      log('ResP3 ${error.toString()}');
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

  List<String> getImage64List(String img) {
    List<String> image64List = <String>[];
    var b = (img.split(','));
    for (String data in b!) {
      image64List.add(networkImageToBase64(data).toString());
    }
    return image64List;
  }

  Future<String?> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(imageUrl as Uri);
    final bytes = response.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }
}
