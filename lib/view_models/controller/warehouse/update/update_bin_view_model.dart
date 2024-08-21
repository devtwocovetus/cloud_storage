import 'dart:developer';

import 'package:cold_storage_flutter/view_models/controller/warehouse/update/update_warehouse_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../models/entity/entity_list_model.dart';
import '../../../../models/storage_type/storage_types.dart';
import '../../../../repository/warehouse_repository/warehouse_repository.dart';
import '../../../../utils/utils.dart';

class UpdateBinViewModel extends GetxController{
  UpdateBinViewModel({required this.binIndex});
  int binIndex = 0;
  final _api = WarehouseRepository();
  final UpdateWarehouseViewModel _updateWarehouseViewModel = Get.put(UpdateWarehouseViewModel());

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
  Rx<StorageType>? storageType = StorageType().obs;

  RxList<StorageType> storageTypeList = <StorageType>[].obs;
  Rx<EntityBinMaster> entityBin = EntityBinMaster().obs;

  // var storageTypeListId = <int?>[].obs;

  @override
  void onInit() {
    log('binIndex : $binIndex');
    entityBin.value = _updateWarehouseViewModel.entityBinList[binIndex];
    getStorageType();
    assignValuesToFields();
    super.onInit();
  }

  assignValuesToFields(){
    binNameController.value.text = entityBin.value.binName ?? '';
    storageConditionController.value.text = entityBin.value.storageCondition ?? '';
    capacityController.value.text = entityBin.value.capacity ?? '';
    maxTempController.value.text = entityBin.value.temperatureMax ?? '';
    minTempController.value.text = entityBin.value.temperatureMin ?? '';
    maxHumidityController.value.text = entityBin.value.humidityMax ?? '';
    minHumidityController.value.text = entityBin.value.humidityMin ?? '';
    otherStorageTypeController.value.text = entityBin.value.typeOfStorageOther ?? '';
    int index =  storageTypeList.indexWhere((e) {
      return e.id == entityBin.value.typeOfStorage;
    });
    if(index >= 0){
      storageType!.value = storageTypeList[index];
    }
    print('storageType!.value : ${storageType!.value}');
    // storageTypeList.firstWhere(test)
  }

  Future getStorageType() async {
    EasyLoading.show(status: 'loading...');
    _api.storageTypeListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        StorageTypeModel storageTypeModel = StorageTypeModel.fromJson(value);
        storageTypeList.value = storageTypeModel.type!;
        // storageTypeListId.value =
        //     storageTypeModel.type!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}