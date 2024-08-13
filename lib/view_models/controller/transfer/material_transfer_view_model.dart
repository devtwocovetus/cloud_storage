import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cold_storage_flutter/data/network/dio_services/api_client.dart';
import 'package:cold_storage_flutter/data/network/dio_services/api_provider/material_provider.dart';
import 'package:cold_storage_flutter/extensions/extension.dart';
import 'package:cold_storage_flutter/models/material_in/material_in_client_model.dart';
import 'package:cold_storage_flutter/repository/material_in_repository/material_in_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_prefrence_view_model.dart';

class MaterialTransferViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = MaterialInRepository();

  var clientList = <String>[].obs;
  var clientListId = <int?>[].obs;
  RxString mStrClient = ''.obs;

 

  var binList = <String>[].obs;
  var binListId = <int?>[].obs;
  RxString mStrBin = ''.obs;
  RxBool isCustomMapping = false.obs;

 final entityNameController = TextEditingController().obs;
  final entityNameFocusNode = FocusNode().obs;
  final clientNameController = TextEditingController().obs;
  final clientNameFocusNode = FocusNode().obs;
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
  RxString signatureFilePath = ''.obs;
  RxString signatureBase64 = ''.obs;
  RxBool isConfirm = false.obs;

  @override
  void onInit() {
    // if (argumentData != null) {
    //   entityName.value = argumentData[0]['entityName'];
    //   entityId.value = argumentData[0]['entityId'];
    //   entityType.value = argumentData[0]['entityType'];
    // }
    // entityNameController.value.text = entityName.value.toCapitalize();
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    //getClient();

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

  void getClient() {
    EasyLoading.show(status: 'loading...');
    _api.getClient().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialInClientModel materialInClientModel =
            MaterialInClientModel.fromJson(value);
        clientList.value =
            materialInClientModel.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
        clientListId.value =
            materialInClientModel.data!.map((data) => data.id).toList();
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

  Future<void> addMaterialIn() async {
    int indexClient = clientList.indexOf(mStrClient.toString());
    EasyLoading.show(status: 'It will take upto 3 minutes..');
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
      buffer.write('"${urlList[i]}"');
      if (i < urlList.length - 1) {
        buffer.write(',');
      }
    }
    // buffer.write();
    return buffer.toString();
  }
}
