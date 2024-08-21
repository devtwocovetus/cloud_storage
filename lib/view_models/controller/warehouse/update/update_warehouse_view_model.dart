import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/models/storage_type/storage_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../../models/home/user_list_model.dart';
import '../../../../repository/warehouse_repository/warehouse_repository.dart';
import '../../../../utils/utils.dart';
import '../../user_preference/user_prefrence_view_model.dart';

class UpdateWarehouseViewModel extends GetxController{
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
  Rx<TextEditingController> phoneC = TextEditingController().obs;
  RxString countryCode = ''.obs;

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

  RxString logoUrl = ''.obs;
  RxList<UsersList>? userList = <UsersList>[].obs;
  String managerId = '';
  late Entity updatingEntity;


  ///For Image
  XFile? image;
  final ImagePicker picker = ImagePicker();
  RxString imageBase64 = ''.obs;

  ///Bin Creation
  RxInt createdBinCount = 0.obs;
  RxBool addBinFormOpen = false.obs;
  TextEditingController binNameC = TextEditingController();
  RxString binTypeOfStorageId = ''.obs;
  RxList<StorageType>? storageTypeList = <StorageType>[].obs;
  RxList<EntityBinMaster> entityBinList = <EntityBinMaster>[].obs;

  @override
  void onInit() {
    if (argumentData != null) {
      updatingEntity = argumentData['entity'];
    }
    log('updatingEntity : ${jsonEncode(updatingEntity.toJson())}');
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getManagerName();
    getStorageType();
    assignValuesToFields();
    super.onInit();
  }

  assignValuesToFields(){
    storageNameC.text = updatingEntity.name ?? '';
    emailC.text = updatingEntity.email ?? '';
    addressC.text = updatingEntity.address ?? '';
    phoneC.value.text = updatingEntity.phone ?? '';
    ownerNameC.text = updatingEntity.ownerName ?? '';
    managerId = updatingEntity.managerId.toString() ?? '';
    profilePicC.text = updatingEntity.profileImage ?? '';
    capacityC.text = updatingEntity.capacity ?? '';
    tempRangeMaxC.text = updatingEntity.temperatureMax ?? '';
    tempRangeMinC.text = updatingEntity.temperatureMax ?? '';
    humidityRangeMaxC.text = updatingEntity.humidityMax ?? '';
    humidityRangeMinC.text = updatingEntity.humidityMin ?? '';
    complianceTagsList.value = stringToList(updatingEntity.complianceCertificates) ?? [];
    regulationInfoC.text = updatingEntity.regulatoryInformation ?? '';
    safetyMeasureTagsList.value = stringToList(updatingEntity.safetyMeasures) ?? [];
    operationalHourStartC.text = updatingEntity.operationalHoursStart ?? '';
    operationalHourEndC.text = updatingEntity.operationalHoursEnd ?? '';
    entityBinList.value = updatingEntity.entityBinMaster ?? [];
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

  @override
  void dispose() {
    // TODO: implement dispose
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


  List<String>? stringToList(String? urlString) {
    // Convert list of strings to one single string including its brackets and double quotation marks
    if (urlString == null || urlString.isEmpty) {
      return [];
    }

    String cleanedInput = urlString.replaceAll(r'\"', '')
        .replaceAll('\"', '');
    List<String> list = cleanedInput.split(',');
    print('updatingEntity $list');
    return list;
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