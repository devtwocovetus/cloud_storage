import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cold_storage_flutter/data/network/dio_services/api_client.dart';
import 'package:cold_storage_flutter/data/network/dio_services/api_provider/warehouse_provider.dart';
import 'package:cold_storage_flutter/view_models/controller/entity/entitylist_view_model.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/controller/entity/new_entitylist_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../models/home/user_list_model.dart';
import '../../../models/storage_type/storage_types.dart';
import '../../../repository/warehouse_repository/warehouse_repository.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_prefrence_view_model.dart';

class WareHouseViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = WarehouseRepository();
  TextEditingController storageNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController profilePicC = TextEditingController();
  TextEditingController capacityC = TextEditingController();
  TextEditingController tempRangeMaxC = TextEditingController();
  TextEditingController tempRangeMinC = TextEditingController();
  TextEditingController humidityRangeMaxC = TextEditingController();
  TextEditingController humidityRangeMinC = TextEditingController();
  TextEditingController ownerNameC = TextEditingController();
  TextEditingController regulationInfoC = TextEditingController();
  TextEditingController operationalHourStartC = TextEditingController();
  TextEditingController operationalHourEndC = TextEditingController();



 final storageNameCFocusNode = FocusNode().obs;
  final emailCFocusNode = FocusNode().obs;
  final addressCFocusNode = FocusNode().obs;
  final profilePicCFocusNode = FocusNode().obs;
  final capacityCFocusNode = FocusNode().obs;
  final tempRangeMaxCFocusNode = FocusNode().obs;
  final tempRangeMinCFocusNode = FocusNode().obs;
  final humidityRangeMaxCFocusNode = FocusNode().obs;
  final humidityRangeMinCFocusNode = FocusNode().obs;
  final ownerNameCFocusNode = FocusNode().obs;
  final regulationInfoCFocusNode = FocusNode().obs;
  final operationalHourStartCFocusNode = FocusNode().obs;
  final operationalHourEndCFocusNode = FocusNode().obs;
  

  Rx<TextEditingController> phoneC = TextEditingController().obs;


  RxString countryCode = ''.obs;

  XFile? image;
  final ImagePicker picker = ImagePicker();
  RxString imageBase64 = ''.obs;

  
  RxList<UsersList>? userList = <UsersList>[].obs;
  String managerId = '';
  RxString logoUrl = ''.obs;

  ///For Compliance Certificate
  Rx<StringTagController<String>> complianceTagController =
      StringTagController().obs;
  Rx<InputFieldValues<String>> complianceFieldValues = InputFieldValues<String>(
          textEditingController: TextEditingController(),
          focusNode: FocusNode(),
          error: 'error',
          onTagChanged: (tag) {},
          onTagSubmitted: (tag) {},
          onTagRemoved: (tag) {},
          tags: [],
          tagScrollController: ScrollController())
      .obs;
  RxList<String> complianceTagsList = <String>[].obs;
  ScrollController complianceTagScroller = ScrollController();
  RxBool visibleComplianceTagField = false.obs;
  // TextEditingController complianceC = TextEditingController();

  ///For Safety Measures
  Rx<StringTagController<String>> safetyMeasureTagController =
      StringTagController().obs;
  Rx<InputFieldValues<String>> safetyMeasureFieldValues =
      InputFieldValues<String>(
              textEditingController: TextEditingController(),
              focusNode: FocusNode(),
              error: 'error',
              onTagChanged: (tag) {},
              onTagSubmitted: (tag) {},
              onTagRemoved: (tag) {},
              tags: [],
              tagScrollController: ScrollController())
          .obs;
  RxList<String> safetyMeasureTagsList = <String>[].obs;
  ScrollController safetyMeasureTagScroller = ScrollController();
  RxBool visibleSafetyMeasureTagField = false.obs;
  // TextEditingController safetyMeasureC = TextEditingController();

 

  ///Bin Creation
  RxInt createdBinCount = 0.obs;
  RxBool addBinFormOpen = false.obs;

  TextEditingController binNameC = TextEditingController();
  RxString binTypeOfStorageId = ''.obs;
  

  RxList<StorageType>? storageTypeList = <StorageType>[].obs;
  RxList<Map<String, dynamic>> entityBinList = <Map<String, dynamic>>[].obs;

  RxString inComingStatus = ''.obs;

  @override
  void onInit() {
    print('inComingStatus.value : $argumentData');
    if (argumentData != null) {
      inComingStatus.value = argumentData[0]['EOB'];
    }
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    userPreference.getUserName().then((value) {
      ownerNameC.text = value.toString();
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
      profilePicC.text = image!.name.toString();
    }
  }

  Future getManagerName() async {
    EasyLoading.show(status: 'loading...');

    _api.managerListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        UserListModel userListModel = UserListModel.fromJson(value);
        userList?.value =
            userListModel.data!.users!.map((data) => data).toList();
        log('userList?.value : ${userListModel.data!.users!.map((data) => data).toList()}');
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
        log('storageTypeList?.value : ${storageTypeModel.type!}');
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  addBinToList(Map<String, dynamic> bin) {
    entityBinList.add(bin);
    log("entityBinList : ${jsonEncode(entityBinList)}");
  }

  // Future<void> addColdStorage() async {
  //   EasyLoading.show(status: 'loading...');
  //   print("entityBinList.value ::: ${entityBinList.value.map((e) => jsonEncode(e),).toList()}");
  //
  //   print("List ::: ${complianceTagsList.value.map((e) => e.toString(),).toList()}");
  //   Map data = {
  //     'name': storageNameC.text.toString(),
  //     'email': emailC.text.toString(),
  //     'address': addressC.text.toString(),
  //     'phone': '${countryCode.value.toString()}${phoneC.value.text.toString()}',
  //     'capacity': capacityC.text.toString(),
  //     'temperature_min': tempRangeMinC.text.toString(),
  //     'temperature_max': tempRangeMaxC.text.toString(),
  //     'humidity_min': tempRangeMinC.text.toString(),
  //     'humidity_max': humidityRangeMaxC.text.toString(),
  //     'owner_name': /*ownerNameC.text.toString()*/ 'Mayur patel',
  //     'manager_id': managerId,
  //     'compliance_certificates': listToString(complianceTagsList.value),
  //     'regulatory_information': regulationInfoC.text.toString(),
  //     'safety_measures': listToString(safetyMeasureTagsList.value),
  //     'operational_hours_start': operationalHourStartC.text.toString(),
  //     'operational_hours_end': operationalHourEndC.text.toString(),
  //     'profile_image': imageBase64.value,
  //     'entity_bin_master[0]': [{
  //       "bin_name": "sdfd",
  //       "type_of_storage": "1",
  //       "type_of_storage_other": "",
  //       "storage_condition": "sdfdsf",
  //       "capacity": "34234",
  //       "temperature_min": "-20°C",
  //       "temperature_max": "-10°C",
  //       "humidity_min": "-20°C",
  //       "humidity_max": "-10°C"
  //     }],
  //     'status': '1',
  //   };
  //   log('DataMap : ${data.toString()}');
  //   _api.addColdStorageApi(data).then((value) {
  //     EasyLoading.dismiss();
  //     if (value['status'] == 0) {
  //       print('ResP1 ${value['message']}');
  //     } else {
  //       print('ResP2 ${value['message']}');
  //       Utils.isCheck = true;
  //       Utils.snackBar('Account', 'Entity created successfully');
  //       if (inComingStatus.value == 'NEW') {
  //         final entityListViewModel = Get.put(NewEntitylistViewModel());
  //         entityListViewModel.getEntityList();
  //         Get.until((route) => Get.currentRoute == RouteName.newEntityListScreen);
  //       } else if (inComingStatus.value == 'OLD') {
  //         final entityListViewModel = Get.put(EntitylistViewModel());
  //         entityListViewModel.getEntityList();
  //         Get.until((route) => Get.currentRoute == RouteName.entityListScreen);
  //       }
  //     }
  //   }).onError((error, stackTrace) {
  //     EasyLoading.dismiss();
  //     Utils.snackBar('Error', error.toString());
  //     print('ResP3 ${error.toString()}');
  //   });
  // }

  Future<void> addColdStorage2() async {
    EasyLoading.show(status: 'loading...');
    log("entityBinList.value ::: ${entityBinList.value.map(
          (e) => jsonEncode(e),
        ).toList()}");
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
      'owner_name': ownerNameC.text.toString(),
      'manager_id': managerId,
      'compliance_certificates': listToString(complianceTagsList.value),
      'regulatory_information': regulationInfoC.text.toString(),
      'safety_measures': listToString(safetyMeasureTagsList.value),
      'operational_hours_start': operationalHourStartC.text.toString(),
      'operational_hours_end': operationalHourEndC.text.toString(),
      'profile_image': imageBase64.value,
      'entity_bin_master': entityBinList.value
          .map(
            (e) => e,
          )
          .toList(),
      'status': '1',
    };
    log('DataMap : ${data.toString()}');
    DioClient client = DioClient();
    final api2 = WarehouseProvider(client: client.init());
    api2.addColdStorageApi(data: data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        log('ResP1 ${value['message']}');
      } else {
        log('ResP2 ${value['message']}');
        Utils.isCheck = true;
        Utils.snackBar('Success', 'Entity created successfully');
        log('inComingStatus.value ${inComingStatus.value}');

        if (inComingStatus.value == 'NEW') {
          final entityListViewModel = Get.put(NewEntitylistViewModel());
          entityListViewModel.getEntityList();
          Get.until(
              (route) => Get.currentRoute == RouteName.newEntityListScreen);
        } else if (inComingStatus.value == 'OLD') {
          final entityListViewModel = Get.put(EntitylistViewModel());
          entityListViewModel.getEntityList();
          Get.until((route) => Get.currentRoute == RouteName.entityListScreen);
        }
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

  Future<void> selectTime(TextEditingController con) async {
    final selectedTime = TimeOfDay.now();
    final TimeOfDay? pickedTime = await showTimePicker(

        context: Get.context!,
        initialTime: selectedTime,
        builder:(context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      ));
    if (pickedTime != null && pickedTime != selectedTime)
     {
       var df = DateFormat("h:mm a");
       var dt = df.parse(pickedTime.format(Get.context!));
       var finalTime =  DateFormat('HH:mm').format(dt);
       con.text = finalTime.toString();
       // con.text = '${pickedTime.hour}:${pickedTime.minute}';
     }
  }
}
