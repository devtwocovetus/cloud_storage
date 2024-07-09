import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cold_storage_flutter/view_models/controller/entity/entitylist_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../models/home/user_list_model.dart';
import '../../../models/storage_type/storage_types.dart';
import '../../../repository/warehouse_repository/warehouse_repository.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_prefrence_view_model.dart';

class WareHouseViewModel extends GetxController{

  final _api = WarehouseRepository();

  TextEditingController storageNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  Rx<TextEditingController> phoneC = TextEditingController().obs;
  RxString countryCode = ''.obs;
  TextEditingController profilePicC = TextEditingController();
  XFile? image;
  final ImagePicker picker = ImagePicker();
  RxString imageBase64 = ''.obs;
  // RxString imageFilePath = ''.obs;

  TextEditingController capacityC = TextEditingController();
  TextEditingController tempRangeMaxC = TextEditingController();
  TextEditingController tempRangeMinC = TextEditingController();
  TextEditingController humidityRangeMaxC = TextEditingController();
  TextEditingController humidityRangeMinC = TextEditingController();
  TextEditingController ownerNameC = TextEditingController();
  RxList<UsersList>? userList = <UsersList>[].obs;
  // StorageType otherType = StorageType.fromJson({
  // 'id' : 9,
  // 'name' : 'OTHER',
  // 'description' : '',
  // 'status' : '1',
  // 'createdBy' : null,
  // 'createdAt' : '',
  // 'updatedAt' : '',
  // 'deletedAt' : '',
  // });
  String managerId = '';
  RxString logoUrl = ''.obs;
   final entityListViewModel = Get.put(EntitylistViewModel());

  ///For Compliance Certificate
  Rx<StringTagController<String>> complianceTagController = StringTagController().obs;
  Rx<InputFieldValues<String>> complianceFieldValues = InputFieldValues<String>(
      textEditingController: TextEditingController(),
      focusNode: FocusNode(),
      error: 'error',
      onTagChanged: (tag) {},
      onTagSubmitted: (tag) {},
      onTagRemoved: (tag) {},
      tags: [],
      tagScrollController: ScrollController()
  ).obs;
  RxList<String> complianceTagsList = <String>[].obs;
  ScrollController complianceTagScroller = ScrollController();
  RxBool visibleComplianceTagField = false.obs;
  // TextEditingController complianceC = TextEditingController();


  ///For Safety Measures
  Rx<StringTagController<String>> safetyMeasureTagController = StringTagController().obs;
  Rx<InputFieldValues<String>> safetyMeasureFieldValues = InputFieldValues<String>(
      textEditingController: TextEditingController(),
      focusNode: FocusNode(),
      error: 'error',
      onTagChanged: (tag) {},
      onTagSubmitted: (tag) {},
      onTagRemoved: (tag) {},
      tags: [],
      tagScrollController: ScrollController()
  ).obs;
  RxList<String> safetyMeasureTagsList = <String>[].obs;
  ScrollController safetyMeasureTagScroller = ScrollController();
  RxBool visibleSafetyMeasureTagField = false.obs;
  // TextEditingController safetyMeasureC = TextEditingController();


  TextEditingController regulationInfoC = TextEditingController();
  TextEditingController operationalHourStartC = TextEditingController();
  TextEditingController operationalHourEndC = TextEditingController();

  ///Bin Creation
  RxInt createdBinCount = 0.obs;
  RxBool addBinFormOpen = false.obs;

  TextEditingController binNameC = TextEditingController();
  RxString binTypeOfStorageId = ''.obs;
  TextEditingController binOtherStorageNameC = TextEditingController();
  TextEditingController binStorageConditionC = TextEditingController();
  TextEditingController binStorageCapacityC = TextEditingController();
  TextEditingController binTempRangeMaxC = TextEditingController();
  TextEditingController binTempRangeMinC = TextEditingController();
  TextEditingController binHumidityRangeMaxC = TextEditingController();
  TextEditingController binHumidityRangeMinC = TextEditingController();
  RxList<StorageType>? storageTypeList = <StorageType>[].obs;
  RxList<Map<String,dynamic>> entityBinList = <Map<String,dynamic>>[].obs;

  @override
  void onInit() {
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getManagerName();
    getStorageType();
    super.onInit();
  }

  @override
  void dispose() {
    complianceTagController.value.dispose();
    safetyMeasureTagController.value.dispose();
    super.dispose();
  }

  Future<void> imageBase64Convert() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      imageBase64.value = '';
      profilePicC.text = '';
    } else {
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
      imageBase64.value = base64Image;
      profilePicC.text = image!.path.toString();
    }
  }

  Future getManagerName() async {
    EasyLoading.show(status: 'loading...');

    _api.managerListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        UserListModel userListModel = UserListModel.fromJson(value);
        userList?.value = userListModel.data!.users!.map((data) => data).toList();
        print('userList?.value : ${userListModel.data!.users!.map((data) => data).toList()}');
        // userLeftCount.value = userListModel.data!.commonDetails!.usersLeftCount!;
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future getStorageType() async {
    EasyLoading.show(status: 'loading...');
    _api.storageTypeListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        StorageTypeModel storageTypeModel = StorageTypeModel.fromJson(value);
        storageTypeList?.value = storageTypeModel.type!;
        // storageTypeList?.add(otherType);
        print('storageTypeList?.value : ${storageTypeModel.type!}');
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  addBinToList(){
    Map<String,dynamic> bin = {
      "bin_name": binNameC.value.text.toString(),
      "type_of_storage": binTypeOfStorageId.value.toString(),
      "type_of_storage_other": binOtherStorageNameC.value.text.toString(),
      "storage_condition": binStorageConditionC.value.text.toString(),
      "capacity": binStorageCapacityC.value.text.toString(),
      "temperature_min": binTempRangeMinC.value.text.toString(),
      "temperature_max": binTempRangeMaxC.value.text.toString(),
      "humidity_min": binHumidityRangeMinC.value.text.toString(),
      "humidity_max": binHumidityRangeMaxC.value.text.toString()
    };
    entityBinList.add(bin);
    print("entityBinList : ${jsonEncode(entityBinList)}");

    binNameC.clear();
    binTypeOfStorageId.value = '';
    binOtherStorageNameC.clear();
    binStorageConditionC.clear();
    binStorageCapacityC.clear();
    binTempRangeMinC.clear();
    binTempRangeMaxC.clear();
    binHumidityRangeMinC.clear();
    binHumidityRangeMaxC.clear();
  }

  Future<void> addColdStorage() async {
    EasyLoading.show(status: 'loading...');
    print("entityBinList.value ::: ${entityBinList.value.map((e) => jsonEncode(e),).toList()}");
    Map data = {
      'name': storageNameC.text.toString(),
      'email': emailC.text.toString(),
      'address': addressC.text.toString(),
      'phone': '${countryCode.value.toString()}${phoneC.value.text.toString()}',
      'capacity': capacityC.text.toString(),
      'temperature_min': tempRangeMinC.text.toString(),
      'temperature_max': tempRangeMaxC.text.toString(),
      'humidity_min': tempRangeMinC.text.toString(),
      'humidity_max': humidityRangeMaxC.text.toString(),
      'owner_name': /*ownerNameC.text.toString()*/'Mayur patel',
      'manager_id': managerId,
      'compliance_certificates': listToString(complianceTagsList.value),
      'regulatory_information': regulationInfoC.text.toString(),
      'safety_measures': listToString(safetyMeasureTagsList.value),
      'operational_hours_start': operationalHourStartC.text.toString(),
      'operational_hours_end': operationalHourEndC.text.toString(),
      'profile_image': imageBase64.value,
      // 'entity_bin_master': entityBinList.value,
      'status': '1',
    };
    log('DataMap : ${data.toString()}');
    _api.addColdStorageApi(data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
        print('ResP1 ${value['message']}');
      } else {
        print('ResP2 ${value['message']}');
        Utils.isCheck = true;
        Utils.snackBar('Account', 'Entity created successfully');
        // entityListViewModel.getEntityList();
        //     Get.back();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
      print('ResP3 ${error.toString()}');
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
