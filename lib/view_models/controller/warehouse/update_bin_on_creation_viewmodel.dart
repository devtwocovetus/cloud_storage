import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../models/storage_type/storage_types.dart';
import '../../../repository/warehouse_repository/warehouse_repository.dart';
import '../../../utils/utils.dart';
import 'create_warehouse_view_model.dart';

class UpdateBinOnCreationViewmodel extends GetxController{
  UpdateBinOnCreationViewmodel({required this.binIndex});
  int binIndex = 0;

  final _api = WarehouseRepository();
  final WareHouseViewModel _updateWarehouseViewModel = Get.put(WareHouseViewModel());

  final binNameController = TextEditingController().obs;
  final storageConditionController = TextEditingController().obs;
  final capacityController = TextEditingController().obs;
  final maxTempController = TextEditingController().obs;
  final minTempController = TextEditingController().obs;
  final maxHumidityController = TextEditingController().obs;
  final minHumidityController = TextEditingController().obs;
  final otherStorageTypeController = TextEditingController().obs;


  final binNameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final storageConditionFocusNode = FocusNode().obs;
  final capacityFocusNode = FocusNode().obs;
  final maxTempFocusNode = FocusNode().obs;
  final minTempFocusNode = FocusNode().obs;
  final maxHumidityFocusNode = FocusNode().obs;
  final minHumidityFocusNode = FocusNode().obs;
  final otherStorageTypeFocusNode = FocusNode().obs;
  StorageType? storageType;
  Rx<String> storageName = ''.obs;

  RxList<StorageType> storageTypeList = <StorageType>[].obs;
  RxMap<String, dynamic> entityBin = <String, dynamic>{}.obs;

  @override
  void onInit() {
    log('binIndex : $binIndex');
    entityBin.value = _updateWarehouseViewModel.entityBinList[binIndex];
    getStorageType();
    assignValuesToFields();
    super.onInit();
  }

  assignValuesToFields(){
    log('BinBin : ${entityBin.value.toString()}');
    binNameController.value.text = entityBin.value['bin_name'] ?? '';
    storageConditionController.value.text = entityBin.value['storage_condition'] ?? '';
    capacityController.value.text = entityBin.value['capacity'] ?? '';
    maxTempController.value.text = entityBin.value['temperature_max'] ?? '';
    minTempController.value.text = entityBin.value['temperature_min'] ?? '';
    maxHumidityController.value.text = entityBin.value['humidity_max'] ?? '';
    minHumidityController.value.text = entityBin.value['humidity_min'] ?? '';
    otherStorageTypeController.value.text = entityBin.value['type_of_storage_other'] ?? '';
  }

  Future getStorageType() async {
    EasyLoading.show(status: 'loading...');
    _api.storageTypeListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        StorageTypeModel storageTypeModel = StorageTypeModel.fromJson(value);
        storageTypeList.value = storageTypeModel.type!;
        if(storageTypeList.isNotEmpty){
          int index = storageTypeList.indexWhere((e) {
            return e.id == int.parse(entityBin.value['type_of_storage']);
          });
          storageType = storageTypeList[index];
          storageName.value = storageType!.name ?? '';
        }
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  updateBinToList(BuildContext context) {
    Map<String, dynamic> bin = {
      "bin_name": binNameController.value.text.toString(),
      "type_of_storage": storageType!.id.toString(),
      "type_of_storage_other": otherStorageTypeController.value.text.toString(),
      "storage_condition": storageConditionController.value.text.toString(),
      "capacity": capacityController.value.text.toString(),
      "temperature_min": minTempController.value.text.toString(),
      "temperature_max": maxTempController.value.text.toString(),
      "humidity_min": minHumidityController.value.text.toString(),
      "humidity_max": maxHumidityController.value.text.toString()
    };
    Utils.snackBar('Bin', 'Bin updated successfully');
    final createMaterialViewModel = Get.put(WareHouseViewModel());
    createMaterialViewModel.updateBinToList(bin,binIndex);
    Get.delete<UpdateBinOnCreationViewmodel>();
    Navigator.pop(context);
  }
}