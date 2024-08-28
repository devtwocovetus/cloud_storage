import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../data/network/dio_services/api_client.dart';
import '../../../data/network/dio_services/api_provider/farmhouse_provider.dart';
import '../../../models/entity/entity_list_model.dart';
import '../../../models/farmhouse/farming_method_model.dart';
import '../../../models/farmhouse/farming_types_model.dart';
import '../../../models/farmhouse/soil_types_model.dart';
import '../../../models/home/user_list_model.dart';
import '../../../repository/farmhouse_repository/farmhouse_repository.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../../setting/entitylist_setting_view_model.dart';
import '../entity/entitylist_view_model.dart';
import '../user_preference/user_prefrence_view_model.dart';

class UpdateFarmhouseViewModel extends GetxController{
  dynamic argumentData = Get.arguments;
  final _api = FarmhouseRepository();

  TextEditingController farmNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController profilePicC = TextEditingController();
  TextEditingController farmSizeC = TextEditingController();
  TextEditingController typeOfFarmingC = TextEditingController();
  TextEditingController ownerNameC = TextEditingController();
  TextEditingController farmingMethodC = TextEditingController();
  TextEditingController irrigationSystemC = TextEditingController();
  Rx<TextEditingController> phoneC = TextEditingController().obs;

  final farmNameCFocusNode = FocusNode().obs;
  final emailCFocusNode = FocusNode().obs;
  final addressCFocusNode = FocusNode().obs;
  final profilePicCFocusNode = FocusNode().obs;
  final farmSizeCFocusNode = FocusNode().obs;
  final typeOfFarmingCFocusNode = FocusNode().obs;
  final ownerNameCFocusNode = FocusNode().obs;
  final farmingMethodCFocusNode = FocusNode().obs;
  final irrigationSystemCFocusNode = FocusNode().obs;

  late Entity updatingEntity;
  String? fromWhere;

  RxString logoUrl = ''.obs;
  RxString countryCode = ''.obs;

  XFile? image;
  final ImagePicker picker = ImagePicker();
  RxString imageBase64 = ''.obs;

  RxList<UsersList>? userList = <UsersList>[].obs;
  UsersList? manager;
  String managerId = '';

  ///For Farming Type
  List<String> farmingTypeIds = [];
  final Rx<MultiSelectController<String>> farmingTypeController = MultiSelectController<String>().obs;
  RxBool isFarmingTypeTextFieldExpanded = false.obs;
  TextEditingController farmingTypeTextC = TextEditingController();
  RxList<FarmingType>? farmingTypesList = <FarmingType>[].obs;
  RxList<DropdownItem<String>>? farmingTypeDropdownItems = <DropdownItem<String>>[].obs;
  RxBool hasFarmingTypeData = false.obs;

  ///For Farming Method
  List<String> farmingMethodIds = [];
  final Rx<MultiSelectController<String>> farmingMethodController = MultiSelectController<String>().obs;
  RxBool isFarmingMethodTextFieldExpanded = false.obs;
  TextEditingController farmingMethodTextC = TextEditingController();
  RxList<FarmingMethods>? farmingMethodsList = <FarmingMethods>[].obs;
  RxList<DropdownItem<String>>? farmingMethodDropdownItems = <DropdownItem<String>>[].obs;
  RxBool hasFarmingMethodData = false.obs;

  ///For Soil Type
  List<String> soilTypeIds = [];
  final Rx<MultiSelectController<String>> typeOfSoilController = MultiSelectController<String>().obs;
  RxBool isSoilTextFieldExpanded = false.obs;
  TextEditingController typeOfSoilTextC = TextEditingController();
  RxList<SoilType>? soilTypesList = <SoilType>[].obs;
  RxList<DropdownItem<String>>? soilDropdownItems = <DropdownItem<String>>[].obs;
  RxBool hasSoilTypeData = false.obs;

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
      tagScrollController: ScrollController()).obs;
  RxList<String> complianceTagsList = <String>[].obs;
  ScrollController complianceTagScroller = ScrollController();
  RxBool visibleComplianceTagField = false.obs;
  // TextEditingController complianceC = TextEditingController();

  ///For Storage Facility
  Rx<StringTagController<String>> storageFacilityTagController = StringTagController().obs;
  Rx<InputFieldValues<String>> storageFacilityFieldValues = InputFieldValues<String>(
      textEditingController: TextEditingController(),
      focusNode: FocusNode(),
      error: 'error',
      onTagChanged: (tag) {},
      onTagSubmitted: (tag) {},
      onTagRemoved: (tag) {},
      tags: [],
      tagScrollController: ScrollController())
      .obs;
  RxList<String> storageFacilityTagsList = <String>[].obs;
  ScrollController storageFacilityTagScroller = ScrollController();
  RxBool visibleStorageFacilityTagField = false.obs;
  // TextEditingController safetyMeasureC = TextEditingController();
  RxString inComingStatus = ''.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      if(argumentData['from_where'] != null){
        fromWhere = argumentData['from_where'];
      }
      updatingEntity = argumentData['entity'];
      log('updatingEntity : ${jsonEncode(updatingEntity)}');
    }
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    userPreference.getUserName().then((value) {
      print("abc<>< : ${value.toString()}");
      ownerNameC.text = value.toString();
      print("abc<>< : ${ownerNameC.text}");
    });
    getManagerName();
    getSoilTypes();
    getFarmingTypes();
    getFarmingMethods();
    assignValuesToFields();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  assignValuesToFields(){
    farmNameC.text = updatingEntity.name.toString().replaceAll('null','') ?? '';
    emailC.text = updatingEntity.email.toString().replaceAll('null','') ?? '';
    addressC.text = updatingEntity.address.toString().replaceAll('null','') ?? '';
    String phone = updatingEntity.phone.toString().replaceAll('null','') ?? '';
    int rem = phone.length - 10;
    phoneC.value.text = phone.substring(rem,phone.length);
    countryCode.value = phone.substring(0,rem);
    farmSizeC.text = updatingEntity.farmSize ?? '';
    // typeOfFarmingC.text = updatingEntity.typeOfFarming ?? '';
    ownerNameC.text = updatingEntity.ownerName.toString().replaceAll('null','') ?? '';
    managerId = updatingEntity.managerId.toString() ?? '';
    irrigationSystemC.text = updatingEntity.irrigationSystem.toString().replaceAll('null','') ?? '';
    complianceTagsList.value = stringToList(updatingEntity.complianceCertificates) ?? [];
    storageFacilityTagsList.value = stringToList(updatingEntity.storageFacilities) ?? [];

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

  Future getFarmingTypes() async{
    EasyLoading.show(status: 'loading...');
    _api.farmingTypeListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        debugPrint('FARMINGTYPE?.value : ${value['message']}');
      } else {
        farmingTypeIds = stringToList(updatingEntity.typeOfFarming) ?? [];
        FarmingTypeModel farmingType = FarmingTypeModel.fromJson(value);
        log('FARMINGTYPE?.value 1: ${value['data']}');
        farmingTypesList?.value = farmingType.data!.map((e) => e).toList();
        farmingTypeDropdownItems?.value = farmingType.data!.map((e) {
          if(e.id.toString() != '11'){
            if(farmingTypeIds.contains(e.id.toString())){
              print('Im here FARMINGTYPE 2 : ${e.id.toString()}');
              return DropdownItem<String>(label: e.name.toString(), value: e.id.toString(),selected: true);
            }else{
              return DropdownItem<String>(label: e.name.toString(), value: e.id.toString());
            }
          }else{
            return DropdownItem<String>(label: e.name.toString(), value: e.id.toString(),disabled: true);
          }
        }).toList();
        hasFarmingTypeData.value = true;
        farmingTypeController.value.addItems(farmingTypeDropdownItems!);
        print('FARMINGTYPE?.value 2: ${farmingTypeDropdownItems.toString()}');
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future getFarmingMethods() async{
    EasyLoading.show(status: 'loading...');
    _api.farmingMethodsListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        debugPrint('FARMINGMETHOD?.value : ${value['message']}');
      } else {
        farmingMethodIds = stringToList(updatingEntity.farmingMethod) ?? [];
        FarmingMethodModel farmingMethods = FarmingMethodModel.fromJson(value);
        log('FARMINGMETHOD?.value 1: ${value['data']}');
        farmingMethodsList?.value = farmingMethods.data!.map((e) => e).toList();
        farmingMethodDropdownItems?.value = farmingMethods.data!.map((e) {
          if(e.id.toString() != '8'){
            if(farmingMethodIds.contains(e.id.toString())){
              print('Im here FARMINGMETHOD: ${e.id.toString()}');
              return DropdownItem<String>(label: e.name.toString(), value: e.id.toString(),selected: true);
            }else{
              return DropdownItem<String>(label: e.name.toString(), value: e.id.toString());
            }
          }else{
            return DropdownItem<String>(label: e.name.toString(), value: e.id.toString(),disabled: true);
          }
        }).toList();
        hasFarmingMethodData.value = true;
        farmingMethodController.value.addItems(farmingMethodDropdownItems!);
        print('FARMINGMETHOD?.value 2: ${farmingMethodDropdownItems.toString()}');
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future getSoilTypes() async{
    EasyLoading.show(status: 'loading...');
    _api.soilTypeListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        debugPrint('SOILLIST?.value : ${value['message']}');
      } else {
        soilTypeIds = stringToList(updatingEntity.soilType) ?? [];
        SoilTypesModel soilTypes = SoilTypesModel.fromJson(value);
        soilTypesList?.value = soilTypes.data!.map((e) => e).toList();
        soilDropdownItems?.value = soilTypes.data!.map((e) {
          if(e.id.toString() != '6'){
            if(soilTypeIds.contains(e.id.toString())){
              print('Im here SOILLIST: ${e.id.toString()}');
              return DropdownItem<String>(label: e.name.toString(), value: e.id.toString(),selected: true);
            }else{
              return DropdownItem<String>(label: e.name.toString(), value: e.id.toString());
            }
          }else{
            return DropdownItem<String>(label: e.name.toString(), value: e.id.toString(),disabled: true);
          }
        }).toList();
        hasSoilTypeData.value = true;
        typeOfSoilController.value.addItems(soilDropdownItems!);
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future addFarmingType(String farmingTypeName) async {
    EasyLoading.show(status: 'loading...');
    _api.addFarmingTypeApi(typeName: {'name': farmingTypeName.trim()}).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        debugPrint('SOILLIST?.value 1: ${value['message']}');
      }else{
        FarmingType farmingType = FarmingType.fromJson(value['data']);
        farmingTypeDropdownItems?.add(
            DropdownItem<String>(label: farmingType.name.toString(), value: farmingType.id.toString())
        );
        farmingTypeController.value.addItem(
            DropdownItem<String>(label: farmingType.name.toString(), value: farmingType.id.toString())
        );
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future addSoilTypes(String soilTYpeName) async {
    EasyLoading.show(status: 'loading...');
    _api.addSoilTypeApi(typeName: {'name': soilTYpeName.trim()}).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        debugPrint('SOILLIST?.value 1: ${value['message']}');
      }else{
        SoilType soilType = SoilType.fromJson(value['data']);
        soilDropdownItems?.add(
            DropdownItem<String>(label: soilType.name.toString(), value: soilType.id.toString())
        );
        typeOfSoilController.value.addItem(
            DropdownItem<String>(label: soilType.name.toString(), value: soilType.id.toString())
        );
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future addFarmingMethod(String farmingMethodName) async {
    EasyLoading.show(status: 'loading...');
    _api.addFarmingMethodApi(typeName: {'name': farmingMethodName.trim()}).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        debugPrint('SOILLIST?.value 1: ${value['message']}');
      }else{
        FarmingMethods farmingMethod = FarmingMethods.fromJson(value['data']);
        farmingMethodDropdownItems?.add(
            DropdownItem<String>(label: farmingMethod.name.toString(), value: farmingMethod.id.toString())
        );
        farmingMethodController.value.addItem(
            DropdownItem<String>(label: farmingMethod.name.toString(), value: farmingMethod.id.toString())
        );
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future getManagerName() async {
    EasyLoading.show(status: 'loading...');

    _api.managerListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        print('userList?.value : ${value['message']}');
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
        print(
            'userList?.value : ${userListModel.data!.users!.map((data) => data).toList()}');
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future<void> updateFarmHouse() async {
    EasyLoading.show(status: 'loading...');
    List<String> soilTypeIds = [];
    for (var soil in typeOfSoilController.value.items) {
      if(soil.selected){
        soilTypeIds.add(soil.value);
      }
    }
    print('SOILLIST?.api : ${listToString(soilTypeIds)}');
    List<String> farmingTypeIds = [];
    for (var type in farmingTypeController.value.items) {
      if(type.selected){
        farmingTypeIds.add(type.value);
      }
    }
    print('SOILLIST?.api : ${listToString(farmingTypeIds)}');
    List<String> farmingMethodIds = [];
    for (var method in farmingMethodController.value.items) {
      if(method.selected){
        farmingMethodIds.add(method.value);
      }
    }
    print('SOILLIST?.api : ${listToString(farmingMethodIds)}');
    Map data = {
      'name': farmNameC.text.toString(),
      'email': emailC.text.toString(),
      'address': addressC.text.toString(),
      'phone': '${countryCode.value.toString()}${phoneC.value.text.toString()}',
      // 'profile_image': imageBase64.value,
      'farm_size': farmSizeC.text.toString(),
      'type_of_farming': listToString(farmingTypeIds),
      'owner_name': ownerNameC.text.toString(),
      'manager_id': managerId.toString(),
      'farming_method': listToString(farmingMethodIds),
      'irrigation_system': irrigationSystemC.text.toString(),
      'soil_type': listToString(soilTypeIds),
      'compliance_certificates': listToString(complianceTagsList.value),
      'storage_facilities': listToString(storageFacilityTagsList.value),
      'status': '1',
    };
    log('DataMap 1: ${data.toString()}');
    if(imageBase64.value.isNotEmpty) {
      print('DataMap 3: ${imageBase64.value.length}');
      data.addAll({ 'profile_image': imageBase64.value,});
    }
    print('DataMap : ${updatingEntity.id}');
    log('DataMap 2: ${data.toString()}');
    DioClient client = DioClient();
    final api2 = FarmhouseProvider(client: client.init());
    api2.updateFarmhouseApi(data: data,id: updatingEntity.id!).then((value) {
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
        }else{
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
}