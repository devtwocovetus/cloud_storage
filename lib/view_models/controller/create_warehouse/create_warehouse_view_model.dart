import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WareHouseViewModel extends GetxController{

  TextEditingController storageNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController capacityC = TextEditingController();
  TextEditingController tempRangeMaxC = TextEditingController();
  TextEditingController tempRangeMinC = TextEditingController();
  TextEditingController humidityRangeMaxC = TextEditingController();
  TextEditingController humidityRangeMinC = TextEditingController();
  TextEditingController ownerNameC = TextEditingController();
  String managerNameC = '';
  TextEditingController regulationInfoC = TextEditingController();
  TextEditingController operationalHourStartC = TextEditingController();
  TextEditingController operationalHourEndC = TextEditingController();

  ///Bin Creation
  RxInt createdBinCount = 0.obs;
  RxBool addBinFormOpen = false.obs;

  TextEditingController binNameC = TextEditingController();
  String binTypeOfStorage = '';
  TextEditingController binStorageConditionC = TextEditingController();
  TextEditingController binStorageCapacityC = TextEditingController();
  TextEditingController binTempRangeMaxC = TextEditingController();
  TextEditingController binTempRangeMinC = TextEditingController();
  TextEditingController binHumidityRangeMaxC = TextEditingController();
  TextEditingController binHumidityRangeMinC = TextEditingController();

}
