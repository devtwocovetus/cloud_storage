import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cold_storage_flutter/data/network/dio_services/api_client.dart';
import 'package:cold_storage_flutter/data/network/dio_services/api_provider/warehouse_provider.dart';
import 'package:cold_storage_flutter/screens/material/material_out/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/view_models/controller/entity/entitylist_view_model.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/controller/entity/new_entitylist_view_model.dart';
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
import '../../setting/entitylist_setting_view_model.dart';
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

  RxBool isAdditionalDetails = false.obs;
  RxString countryCode = ''.obs;

  XFile? image;
  final ImagePicker picker = ImagePicker();
  RxString imageBase64 = ''.obs;

  
  RxList<UsersList>? userList = <UsersList>[].obs;
  String managerId = '';

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





 Future<void> imageBase64Convert(BuildContext context) async {
    DialogUtils.showMediaDialog(context, cameraBtnFunction: () async {
      Get.back(closeOverlays: true);
      image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) {
      imageBase64.value = '';
      profilePicC.text = '';
    } else {
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
      imageBase64.value = base64Image;
      profilePicC.text = image!.name;
      print('<><><>##### ${image!.name}');
    }
    }, libraryBtnFunction: () async {
      Get.back(closeOverlays: true);
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
     imageBase64.value = '';
      profilePicC.text = '';
    } else {
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
      imageBase64.value = base64Image;
      profilePicC.text = image!.name;
      print('<><><>##### ${image!.name}');
    }
    });
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

  updateBinToList(Map<String, dynamic> bin, int index) {
    entityBinList[index] = bin;
    log("entityBinList : ${jsonEncode(entityBinList)}");
  }

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
        }else if(inComingStatus.value == 'setting'){
          final entityListSettingViewModel = Get.put(EntitylistSettingViewModel());
          entityListSettingViewModel.getEntityList();
          Get.until((route) => Get.currentRoute == RouteName.entityListSettingScreen);
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
      buffer.write(urlList[i]);
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
