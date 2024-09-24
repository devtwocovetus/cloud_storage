import 'dart:developer';

import 'package:cold_storage_flutter/models/entity/entity_list_update_model.dart';
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
  StorageType? storageType;
  Rx<String> storageName = ''.obs;

  RxList<StorageType> storageTypeList = <StorageType>[].obs;
  Rx<EntityBinUpdateMaster> entityBin = EntityBinUpdateMaster().obs;

  @override
  void onInit() {
    log('binIndex : $binIndex');
    entityBin.value = _updateWarehouseViewModel.entityBinList[binIndex];
    getStorageType();
    assignValuesToFields();
    super.onInit();
  }

  assignValuesToFields(){
    log('BinBin : ${entityBin.value.toJson().toString()}');
    storageName.value = entityBin.value.typeOfStorageName ?? '';
    binNameController.value.text = entityBin.value.binName ?? '';
    storageConditionController.value.text = entityBin.value.storageCondition ?? '';
    capacityController.value.text = entityBin.value.capacity ?? '';
    maxTempController.value.text = entityBin.value.temperatureMax ?? '';
    minTempController.value.text = entityBin.value.temperatureMin ?? '';
    maxHumidityController.value.text = entityBin.value.humidityMax ?? '';
    minHumidityController.value.text = entityBin.value.humidityMin ?? '';
    otherStorageTypeController.value.text = entityBin.value.typeOfStorageOther ?? '';
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
            return e.id == entityBin.value.typeOfStorage;
          });
          storageType = storageTypeList[index];
        }
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  updateBinToList(BuildContext context) {
    EntityBinUpdateMaster bin = EntityBinUpdateMaster.fromJson({
      "id": entityBin.value.id,
      "bin_name": Utils.textCapitalizationString(binNameController.value.text.toString()),
      "type_of_storage": storageType!.id,
      "type_of_storage_other": Utils.textCapitalizationString(otherStorageTypeController.value.text.toString()),
      "storage_condition": Utils.textCapitalizationString(storageConditionController.value.text.toString()),
      "capacity": capacityController.value.text.toString(),
      "temperature_min": minTempController.value.text.toString(),
      "temperature_max": maxTempController.value.text.toString(),
      "humidity_min": minHumidityController.value.text.toString(),
      "humidity_max": maxHumidityController.value.text.toString()
    });
    log('bin viewModel : ${bin.toString()}');
    bool exists = false;
    final updateWareHouseViewModel = Get.put(UpdateWarehouseViewModel());
    for(int i = 0; i<updateWareHouseViewModel.entityBinList.length; i++){
      EntityBinUpdateMaster e = updateWareHouseViewModel.entityBinList[i];
       if(e.binName.toString().trim().toLowerCase() == binNameController.value.text.toString().trim().toLowerCase() && i != binIndex){
        exists = true;
        Utils.snackBar('Bin', 'The bin name is already exists');
        continue;
      }else{
        exists = false;
      }
    }
    if(!exists){
      Utils.snackBar('Bin', 'Bin updated successfully');
      updateWareHouseViewModel.updateBinToList(bin,binIndex);
      Get.delete<UpdateBinViewModel>();
      Navigator.pop(context);
    }
  }
}