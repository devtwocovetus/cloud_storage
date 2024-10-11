import 'dart:convert';
import 'dart:developer';

import 'package:cold_storage_flutter/data/network/dio_services/api_client.dart';
import 'package:cold_storage_flutter/data/network/dio_services/api_provider/asset_provider.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';
import 'package:cold_storage_flutter/models/cold_asset/asset_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../../models/cold_asset/asset_categories_model.dart';
import '../../../../models/cold_asset/asset_location_model.dart';
import '../../../../models/storage_type/storage_types.dart';
import '../../../../repository/cold_asset_repository/cold_asset_repository.dart';
import '../../../../res/routes/routes_name.dart';
import '../../../../utils/utils.dart';
import '../../user_preference/user_prefrence_view_model.dart';
import '../asset_list_view_model.dart';

class UpdateAssetViewModel extends GetxController{
  dynamic argumentData = Get.arguments;
  final _api = ColdAssetRepository();

  var assetCategoryList = <String>[].obs;
  var assetCategoryListId = <int?>[].obs;
  RxString assetCategory = ''.obs;

  var assetLocationList = <String>[].obs;
  var assetLocationListId = <int?>[].obs;
  var assetLocationListType = <int?>[].obs;
  RxString assetLocation = ''.obs;
  RxString countryCode = ''.obs;
  RxString contactNumber = ''.obs;

  var operationalStatusList = <String>['Active', 'In Repair', 'Retired'].obs;
  RxString operationalStatus = 'Select'.obs;

  final assetNameController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  final manufacturerController = TextEditingController().obs;
  final modelNumberController = TextEditingController().obs;
  final serialNumberController = TextEditingController().obs;

  final assetNameFocusNode = FocusNode().obs;
  final descriptionFocusNode = FocusNode().obs;
  final manufacturerFocusNode = FocusNode().obs;
  final modelNumberFocusNode = FocusNode().obs;
  final serialNumberFocusNode = FocusNode().obs;

  final purchaseDateController = TextEditingController().obs;
  final purchasePriceController = TextEditingController().obs;
  final vendorNameController = TextEditingController().obs;
  final vendorContactController = TextEditingController().obs;
  final vendorEmailController = TextEditingController().obs;
  final invoiceNumberController = TextEditingController().obs;
  final warrantyDetailsController = TextEditingController().obs;

  final purchaseDateFocusNode = FocusNode().obs;
  final purchasePriceFocusNode = FocusNode().obs;
  final vendorNameFocusNode = FocusNode().obs;
  final vendorContactFocusNode = FocusNode().obs;
  final vendorEmailFocusNode = FocusNode().obs;
  final invoiceNumberFocusNode = FocusNode().obs;
  final warrantyDetailsFocusNode = FocusNode().obs;

  final insuranceExpiryDateController = TextEditingController().obs;
  final insuranceProviderController = TextEditingController().obs;
  final insurancePolicyNumberController = TextEditingController().obs;

  final insuranceExpiryDateFocusNode = FocusNode().obs;
  final insuranceProviderFocusNode = FocusNode().obs;
  final insurancePolicyNumberFocusNode = FocusNode().obs;

  final conditionController = TextEditingController().obs;
  final lastUpdatedController = TextEditingController().obs;
  final commentsNotesController = TextEditingController().obs;

  final conditionFocusNode = FocusNode().obs;
  final lastUpdatedFocusNode = FocusNode().obs;
  final commentsNotesFocusNode = FocusNode().obs;

  RxBool isPurchaseFinancialDetails = false.obs;
  RxBool isInsuranceCompliance = false.obs;
  RxBool isOperationalDetails = false.obs;

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

  XFile? image;
  final ImagePicker picker = ImagePicker();
  RxString imageBase64 = ''.obs;

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
  // RxMap<String,dynamic> updatingAsset = <String, dynamic>{}.obs;
  int updatingAssetId = 0;
  late Asset updatingAssetModel;
  @override
  void onInit() {
    if (argumentData != null) {
      log('asset111 : ${argumentData}');
      log('asset111 : ${(argumentData['asset_id'])}');
      updatingAssetId = jsonDecode(argumentData['asset_id']);
    }
    log('asset11 : ${updatingAssetId.toString()}');
    UserPreference userPreference = UserPreference();
    userPreference.getUserName().then((value) {
      ownerNameC.text = value.toString();
    });
    getAssetById(updatingAssetId).then((value) {

    });
    super.onInit();
  }

  Future getAssetById(int id) async {
    EasyLoading.show(status: t.loading);
    _api.getAsset(id: id).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        AssetDetails assetDetails = AssetDetails.fromJson(value);
        updatingAssetModel = assetDetails.data!;
        log('updatingAssetModel : ${updatingAssetModel.toJson()}');
        getCategory();
        getLocation();
        assignInitialValues();

      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  Future getCategory() async {
    EasyLoading.show(status: t.loading);
    _api.getCategories().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        AssetCategoriesModel assetCategoriesModel =
        AssetCategoriesModel.fromJson(value);

        assetCategoryList.value = assetCategoriesModel.data!
            .map((data) => Utils.textCapitalizationString(data.name!))
            .toList();
        assetCategoryListId.value =
            assetCategoriesModel.data!.map((data) => data.id).toList();
        if(assetCategoryListId.value.isNotEmpty){
          int index = assetCategoryListId.value.indexWhere((e) {
            return e == updatingAssetModel.category;
          });
          assetCategory.value = assetCategoryList.value[index];
        }
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  Future getLocation() async {
    EasyLoading.show(status: t.loading);
    _api.getLocation().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        AssetLocationModel assetLocationModel =
        AssetLocationModel.fromJson(value);
        assetLocationList.value = assetLocationModel.data!
            .map((data) => Utils.textCapitalizationString(data.name!))
            .toList();
        assetLocationListId.value =
            assetLocationModel.data!.map((data) => data.id).toList();
        assetLocationListType.value =
            assetLocationModel.data!.map((data) => data.entityType).toList();

        if(assetLocationListId.value.isNotEmpty){
          int index = assetLocationListId.value.indexWhere((e) {
            return e == int.parse(updatingAssetModel.location ?? '0');
          });
          assetLocation.value = assetLocationList.value[index];
        }
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  assignInitialValues(){
    operationalStatus.value = Utils.textCapitalizationString(updatingAssetModel.operationalStatus?.replaceAll('null', '') ?? 'Select');
    assetNameController.value.text = updatingAssetModel.assetName?.replaceAll('null', '') ?? '';
    descriptionController.value.text = updatingAssetModel.description?.replaceAll('null', '') ?? '';
    manufacturerController.value.text = updatingAssetModel.make?.replaceAll('null', '') ?? '';
    modelNumberController.value.text = updatingAssetModel.model?.replaceAll('null', '') ?? '';
    serialNumberController.value.text = updatingAssetModel.serialNumber?.replaceAll('null', '') ?? '';
    purchaseDateController.value.text = updatingAssetModel.purchaseDate?.replaceAll('null', '') ?? '';
    purchasePriceController.value.text = updatingAssetModel.purchasePrice?.replaceAll('null', '') ?? '';
    vendorNameController.value.text = updatingAssetModel.vendorName?.replaceAll('null', '') ?? '';
    vendorEmailController.value.text = updatingAssetModel.vendorEmail?.replaceAll('null', '') ?? '';
    String phone = updatingAssetModel.vendorContactNumber?.replaceAll('null', '') ?? '';
    int rem = phone.length - 10;
    vendorContactController.value.text = phone.substring(rem,phone.length);
    countryCode.value = phone.substring(0,rem);
    // vendorContactController.value.text = updatingAssetModel.vendorContactNumber?.replaceAll('null', '') ?? '';
    invoiceNumberController.value.text = updatingAssetModel.invoiceNumber?.replaceAll('null', '') ?? '';
    warrantyDetailsController.value.text = updatingAssetModel.warrantyDetails?.replaceAll('null', '') ?? '';
    conditionController.value.text = updatingAssetModel.condition?.replaceAll('null', '') ?? '';
    lastUpdatedController.value.text = updatingAssetModel.lastUpdated?.replaceAll('null', '') ?? '';
    commentsNotesController.value.text = updatingAssetModel.comments?.replaceAll('null', '') ?? '';
    insuranceProviderController.value.text = updatingAssetModel.insuranceProvider?.replaceAll('null', '') ?? '';
    insurancePolicyNumberController.value.text = updatingAssetModel.insurancePolicyNumber?.replaceAll('null', '') ?? '';
    insuranceExpiryDateController.value.text = updatingAssetModel.insuranceExpiryDate?.replaceAll('null', '') ?? '';
  }

  void submitUpdateAsset() {
    contactNumber.value =
    '${countryCode.value}${vendorContactController.value.text}';
    int indexCategory =
    assetCategoryList.indexOf(assetCategory.toString().trim());
    int indexLocation =
    assetLocationList.indexOf(assetLocation.toString().trim());
    EasyLoading.show(status: t.loading);
    Map data = {
      'asset_name': Utils.textCapitalizationString(assetNameController.value.text.toString()),
      'category': assetCategoryListId[indexCategory].toString(),
      'location': assetLocationListId[indexLocation].toString(),
      'entity_type': assetLocationListType[indexLocation].toString(),
      'description': Utils.textCapitalizationString(descriptionController.value.text.toString()),
      'make': Utils.textCapitalizationString(manufacturerController.value.text.toString()),
      'model': Utils.textCapitalizationString(modelNumberController.value.text.toString()),
      'serial_number': serialNumberController.value.text.toString(),
      'purchase_date': purchaseDateController.value.text.toString(),
      'purchase_price': purchasePriceController.value.text.toString(),
      'vendor_name': Utils.textCapitalizationString(vendorNameController.value.text.toString()),
      'vendor_contact_number': contactNumber.value.toString(),
      'vendor_email': vendorEmailController.value.text.toString(),
      'invoice_number': invoiceNumberController.value.text.toString(),
      'warranty_details': Utils.textCapitalizationString(warrantyDetailsController.value.text.toString()),
      'operational_status': operationalStatus.value.toString() == 'Select' ? '' : operationalStatus.value.toString(),
      'last_updated': lastUpdatedController.value.text.toString(),
      'condition': conditionController.value.text.toString(),
      'comments': Utils.textCapitalizationString(commentsNotesController.value.text.toString()),
      'insurance_provider': insuranceProviderController.value.text.toString(),
      'insurance_policy_number':
      insurancePolicyNumberController.value.text.toString(),
      'insurance_expiry_date':
      insuranceExpiryDateController.value.text.toString(),
    };
     print('<><>@ ${data.toString()}');
    DioClient client = DioClient();
    final provider = AssetProvider(client: client.init());
    provider.updateAssetApi(data: data, id: updatingAssetId).then((value) {
      EasyLoading.dismiss();
      print('<><> 1');
      if (value['status'] == 0) {
        print('<><> 2');
        // Utils.snackBar('Error', value['message']);
      } else {
        print('<><> 3');
        Utils.isCheck = true;
        Utils.snackBar(t.success_text, t.asset_updated_success_text);
        final assetListViewModel = Get.put(AssetListViewModel());
        assetListViewModel.getAssetList();
        Get.until((route) => Get.currentRoute == RouteName.assetListScreen);
      }
    }).onError((error, stackTrace) {
      print('<><> 4');
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }
}