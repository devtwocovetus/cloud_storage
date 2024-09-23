import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cold_storage_flutter/data/network/dio_services/api_client.dart';
import 'package:cold_storage_flutter/data/network/dio_services/api_provider/warehouse_provider.dart';
import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/models/storage_type/storage_types.dart';
import 'package:cold_storage_flutter/screens/material/material_out/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/view_models/controller/entity/new_entitylist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../../models/entity/entity_list_update_model.dart';
import '../../../../models/home/user_list_model.dart';
import '../../../../repository/warehouse_repository/warehouse_repository.dart';
import '../../../../res/routes/routes_name.dart';
import '../../../../utils/utils.dart';
import '../../../setting/entitylist_setting_view_model.dart';
import '../../entity/entitylist_view_model.dart';
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

  RxList<UsersList>? userList = <UsersList>[].obs;
  UsersList? manager;
  String managerId = '';
  late EntityUpdate updatingEntity;
  String? fromWhere;
  RxBool isAdditionalDetails = false.obs;

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
  RxList<EntityBinUpdateMaster> entityBinList = <EntityBinUpdateMaster>[].obs;

  @override
  void onInit() {
    if (argumentData != null) {
      if(argumentData['from_where'] != null){
        fromWhere = argumentData['from_where'];
      }
      Entity entity = argumentData['entity'];
      updatingEntity = EntityUpdate(
        id: entity.id,
        name: entity.name.toString().replaceAll('null',''),
        accountId: entity.accountId,
        address: entity.address.toString().replaceAll('null',''),
        alarms: entity.alarms.toString().replaceAll('null',''),
        backupPowerSupply: entity.backupPowerSupply.toString().replaceAll('null',''),
        capacity: entity.capacity.toString().replaceAll('null',''),
        complianceCertificates: entity.complianceCertificates.toString().replaceAll('null',''),
        createdAt: entity.createdAt.toString().replaceAll('null',''),
        createdBy: entity.createdBy,
        deletedAt: entity.deletedAt.toString().replaceAll('null',''),
        deletedBy: entity.deletedBy,
        email: entity.email.toString().replaceAll('null',''),
        entityBinMaster: entity.entityBinMaster?.map((e) => EntityBinUpdateMaster(
          validTo: e.validTo.toString().replaceAll('null',''),
          validFrom: e.validFrom.toString().replaceAll('null',''),
          updatedBy: e.updatedBy,
          updatedAt: e.updatedAt.toString().replaceAll('null',''),
          temperatureMin: e.temperatureMin.toString().replaceAll('null',''),
          temperatureMax: e.temperatureMax.toString().replaceAll('null',''),
          status: e.status,
          humidityMin: e.humidityMin.toString().replaceAll('null',''),
          humidityMax: e.humidityMax.toString().replaceAll('null',''),
          deletedBy: e.deletedBy,
          deletedAt: e.deletedAt.toString().replaceAll('null',''),
          createdBy: e.createdBy,
          createdAt: e.createdAt.toString().replaceAll('null',''),
          capacity: e.capacity.toString().replaceAll('null',''),
          accountId: e.accountId,
          id: e.id,
          binName: e.binName.toString().replaceAll('null',''),
          entityId: e.entityId,
          storageCondition: e.storageCondition.toString().replaceAll('null',''),
          typeOfStorage: e.typeOfStorage,
          typeOfStorageName: e.typeOfStorageName.toString().replaceAll('null',''),
          typeOfStorageOther: e.typeOfStorageOther.toString().replaceAll('null',''),
        )).toList(),
        entityType: entity.entityType,
        farmingMethod: entity.farmingMethod,
        farmSize: entity.farmSize,
        humidityMax: entity.humidityMax,
        humidityMin: entity.humidityMin,
        irrigationSystem: entity.irrigationSystem,
        location: entity.location,
        maintenanceSchedule: entity.maintenanceSchedule,
        managerContactInformation: entity.managerContactInformation,
        managerId: entity.managerId,
        managerName: entity.managerName,
        operationalHoursEnd: entity.operationalHoursEnd,
        operationalHoursStart: entity.operationalHoursStart,
        ownerName: entity.ownerName,
        phone: entity.phone,
        profileImage: entity.profileImage,
        regulatoryInformation: entity.regulatoryInformation,
        safetyMeasures: entity.safetyMeasures,
        soilType: entity.soilType,
        status: entity.status,
        storageFacilities: entity.storageFacilities,
        temperatureMax: entity.temperatureMax,
        temperatureMin: entity.temperatureMin,
        temperatureMonitoringSystems: entity.temperatureMonitoringSystems,
        typeOfFarming: entity.typeOfFarming,
        updatedAt: entity.updatedAt,
        updatedBy: entity.updatedBy,
        validFrom: entity.validFrom,
        validTo: entity.validTo,
      );
    }
    log('updatingEntity : ${jsonEncode(updatingEntity.toJson())}');
    getManagerName();
    getStorageType();
    assignValuesToFields();
    super.onInit();
  }


  @override
  void dispose() {
    Get.delete<UpdateWarehouseViewModel>();
    super.dispose();
  }

  Future assignValuesToFields() async{
    storageNameC.text = updatingEntity.name ?? '';
    emailC.text = updatingEntity.email ?? '';
    addressC.text = updatingEntity.address ?? '';
    String phone = updatingEntity.phone ?? '';
    int rem = phone.length - 10;
    phoneC.value.text = phone.substring(rem,phone.length);
    countryCode.value = phone.substring(0,rem);
    ownerNameC.text = updatingEntity.ownerName ?? '';
    managerId = updatingEntity.managerId.toString() ?? '';
    capacityC.text = updatingEntity.capacity ?? '';
    tempRangeMaxC.text = updatingEntity.temperatureMax ?? '';
    tempRangeMinC.text = updatingEntity.temperatureMin ?? '';
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
        if(userList!.value.isNotEmpty){
          int index = userList!.value.indexWhere((e) {
            return e.id == updatingEntity.managerId;
          });
          manager = userList!.value[index];
          log('manager?.value 1: $manager');
        }
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

  updateBinToList(EntityBinUpdateMaster bin, int index) {
    entityBinList[index] = bin;
    log("entityBinList : ${jsonEncode(entityBinList)}");
  }

  addBinToList(EntityBinUpdateMaster bin) {
    entityBinList.add(bin);
    log("entityBinList : ${jsonEncode(entityBinList)}");
  }

  Future<void> updateColdStorage() async {
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
      'humidity_min': humidityRangeMinC.text.toString(),
      'humidity_max': humidityRangeMaxC.text.toString(),
      'owner_name': ownerNameC.text.toString(),
      'manager_id': managerId,
      'compliance_certificates': listToString(complianceTagsList.value),
      'regulatory_information': regulationInfoC.text.toString(),
      'safety_measures': listToString(safetyMeasureTagsList.value),
      'operational_hours_start': operationalHourStartC.text.toString(),
      'operational_hours_end': operationalHourEndC.text.toString(),
      'entity_bin_master': entityBinList.value
          .map(
            (e) {
              if(e.id != null && e.id != 0){
                return {
                  "id": e.id,
                  "bin_name":e.binName.toString(),
                  "type_of_storage": e.typeOfStorage.toString(),
                  "type_of_storage_other": e.toString(),
                  "storage_condition": e.storageCondition.toString(),
                  "capacity": e.capacity.toString(),
                  "temperature_min": e.temperatureMin.toString(),
                  "temperature_max": e.temperatureMax.toString(),
                  "humidity_min": e.humidityMin.toString(),
                  "humidity_max": e.humidityMax.toString()
                };
              }else{
                return {
                  "bin_name":e.binName.toString(),
                  "type_of_storage": e.typeOfStorage.toString(),
                  "type_of_storage_other": e.toString(),
                  "storage_condition": e.storageCondition.toString(),
                  "capacity": e.capacity.toString(),
                  "temperature_min": e.temperatureMin.toString(),
                  "temperature_max": e.temperatureMax.toString(),
                  "humidity_min": e.humidityMin.toString(),
                  "humidity_max": e.humidityMax.toString()
                };
              }
            }).toList(),
      'status': '1',
    };
    if(imageBase64.value.isNotEmpty) {
      print('DataMap 3: ${imageBase64.value.length}');
      data.addAll({'profile_image': imageBase64.value,});
    }
    log('DataMap : ${data.toString()}');
    DioClient client = DioClient();
    final api = WarehouseProvider(client: client.init());
    api.updateColdStorageApi(data: data, id: updatingEntity.id!).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        log('ResP1 ${value['message']}');
      } else {
        log('ResP2 ${value['message']}');
        Utils.isCheck = true;
        Utils.snackBar('Success', 'Entity updated successfully');

        if(fromWhere == 'setting'){
          final entityListSettingViewModel = Get.put(EntitylistSettingViewModel());
          entityListSettingViewModel.getEntityList();
          Get.until((route) => Get.currentRoute == RouteName.entityListSettingScreen);
        }else if(fromWhere == 'new'){
          final newEntityListViewModel = Get.put(NewEntitylistViewModel());
          newEntityListViewModel.getEntityList();
          Get.until((route) => Get.currentRoute == RouteName.newEntityListScreen);
        } else{
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


  List<String>? stringToList(String? urlString) {
    // Convert list of strings to one single string including its brackets and double quotation marks
    if (urlString == null || urlString.isEmpty) {
      return [];
    }
    String cleanedInput = urlString.replaceAll(r'\"', '')
        .replaceAll('\"', '');
    List<String> list = cleanedInput.split(',');
    List<String> newList = list.map((e) {
      return e.toString().trim();
    }).toList();
    return newList;
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