import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cold_storage_flutter/data/network/dio_services/api_client.dart';
import 'package:cold_storage_flutter/data/network/dio_services/api_provider/material_provider.dart';
import 'package:cold_storage_flutter/models/material_out/material_out_client_customer_model.dart';
import 'package:cold_storage_flutter/models/material_out/material_out_client_supplier_model.dart';
import 'package:cold_storage_flutter/models/material_out/material_out_customer_entity_model.dart';
import 'package:cold_storage_flutter/repository/material_out_repository/material_out_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_prefrence_view_model.dart';

class MaterialOutViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = MaterialOutRepository();

  var clientSupplierList = <String>[].obs;
  var clientSupplierListId = <int?>[].obs;
  RxString mStrSupplierClient = ''.obs;
  
  var clientCustomerList = <String>[].obs;
  var clientCustomerListId = <int?>[].obs;
  var clientCustomerListManual = <String>[].obs;
  RxString mStrCustomerClient = ''.obs;
  
  var entityList = <String>[].obs;
  var entityListId = <int?>[].obs;
  var entityListType = <int?>[].obs;
  RxString mStrEntity = ''.obs;

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
  RxString clientId = ''.obs;
  RxString entityId = ''.obs;
  RxString entityType = ''.obs;
  RxString signatureFilePath = ''.obs;
  RxString signatureBase64 = ''.obs;
  RxBool isConfirm = false.obs;
  RxString isManual = '5'.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
      entityType.value = argumentData[0]['entityType'];
    }
    entityNameController.value.text = entityName.value;
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getClientSupplier();
    getClientCustomer();

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

  void getClientSupplier() {
     Map data = {
      'entity_id': entityId.value.toString(),
      'entity_type': entityType.value.toString(),
    };
    EasyLoading.show(status: 'loading...');
    _api.getClientSupplier(data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialOutClientSupplierModel materialInClientModel =
            MaterialOutClientSupplierModel.fromJson(value);
        clientSupplierList.value =
            materialInClientModel.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
        clientSupplierListId.value =
            materialInClientModel.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

   void getClientCustomer() {
    EasyLoading.show(status: 'loading...');
    _api.getClientCustomer().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialOutClientCustomerModel materialInClientModel =
            MaterialOutClientCustomerModel.fromJson(value);
        clientCustomerList.value =
            materialInClientModel.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
        clientCustomerListId.value =
            materialInClientModel.data!.map((data) => data.id).toList();
        clientCustomerListManual.value =
            materialInClientModel.data!.map((data) => data.manualCreation!).toList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

    void getCustomerEntity(String customerId) {
    EasyLoading.show(status: 'loading...');
    _api.getEntityList(customerId).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialOutCustomerEntityModel materialInClientModel =
            MaterialOutCustomerEntityModel.fromJson(value);
        entityList.value =
            materialInClientModel.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
        entityListId.value =
            materialInClientModel.data!.map((data) => data.id).toList();
        entityListType.value =
            materialInClientModel.data!.map((data) => data.entityType).toList();
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

   Future<void> addMaterialOut() async {
     String entityIdTo = '';
     String entityTypeTo = '';
     int indexSupplier = clientSupplierList.indexOf(mStrSupplierClient.toString());
     int indexCustomer = clientCustomerList.indexOf(mStrCustomerClient.toString());
     if(mStrEntity.isNotEmpty){
     int indexEntity = entityList.indexOf(mStrEntity.toString());
         entityIdTo = entityListId[indexEntity].toString();
      entityTypeTo = entityListType[indexEntity].toString();
     }
     EasyLoading.show(status: 'loading...');
     Map data = {
       'entity_id': entityId.value.toString(),
       'entity_type': entityType.value.toString(),
       'client_id': clientSupplierListId[indexSupplier].toString(),
       'customer_id': clientCustomerListId[indexCustomer].toString(),
       'entity_id_to': entityIdTo,
       'entity_type_to': entityTypeTo,
       'transaction_date': dateController.value.text,
       'transaction_type': 'OUT',
       'status': '1',
       'driver_name': driverController.value.text,
       'signature': signatureBase64.value.toString(),
       'transaction_details': entityQuantityListFinal
           .map(
             (e) => e,
           )
           .toList(),
     };
     log('DataMap : ${data.toString()}');
     DioClient client = DioClient();
     final api2 = MaterialProvider(client: client.init());
     api2.addMaterialOut(data: data).then((value) {
       EasyLoading.dismiss();
       if (value['status'] == 0) {
         log('ResP1 ${value['message']}');
       } else {
         log('ResP2 ${value['message']}');
         Get.toNamed(RouteName.materialOutThankyou);
       }
     }).onError((error, stackTrace) {
       EasyLoading.dismiss();
       Utils.snackBar('Error', error.toString());
       log('ResP3 ${error.toString()}');
     });
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
