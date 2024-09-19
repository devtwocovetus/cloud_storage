import 'package:cold_storage_flutter/models/cold_asset/asset_categories_model.dart';
import 'package:cold_storage_flutter/models/cold_asset/asset_location_model.dart';
import 'package:cold_storage_flutter/repository/cold_asset_repository/cold_asset_repository.dart';
import 'package:cold_storage_flutter/view_models/controller/cold_asset/asset_list_view_model.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../models/storage_type/storage_types.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_prefrence_view_model.dart';

class ColdAssetViewModel extends GetxController {
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
  RxString operationalStatus = ''.obs;

  final assetNameController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  final manufacturerController = TextEditingController().obs;
  final modelNumberController = TextEditingController().obs;
  final serialNumberController = TextEditingController().obs;

  final assetNameFocusNode = FocusNode().obs;
  final descriptionFocusNode = FocusNode().obs;
  final manufacturerFocusNode = FocusNode().obs;
  final modelMumberFocusNode = FocusNode().obs;
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

  @override
  void onInit() {
    UserPreference userPreference = UserPreference();
    userPreference.getUserName().then((value) {
      ownerNameC.text = value.toString();
    });

    getCategory();
    getLocation();
    super.onInit();
  }

  Future getCategory() async {
    EasyLoading.show(status: 'loading...');
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
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future getLocation() async {
    EasyLoading.show(status: 'loading...');
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
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void submitAddAsset() {
    contactNumber.value =
        '${countryCode.value}${vendorContactController.value.text}';
    int indexCategory =
        assetCategoryList.indexOf(assetCategory.toString().trim());
    int indexLocation =
        assetLocationList.indexOf(assetLocation.toString().trim());
    EasyLoading.show(status: 'loading...');
    Map data = {
      'asset_name': assetNameController.value.text.toString(),
      'category': assetCategoryListId[indexCategory].toString(),
      'location': assetLocationListId[indexLocation].toString(),
      'entity_type': assetLocationListType[indexLocation].toString(),
      'description': descriptionController.value.text.toString(),
      'make': manufacturerController.value.text.toString(),
      'model': modelNumberController.value.text.toString(),
      'serial_number': serialNumberController.value.text.toString(),
      'purchase_date': purchaseDateController.value.text.toString(),
      'purchase_price': purchasePriceController.value.text.toString(),
      'vendor_name': vendorNameController.value.text.toString(),
      'vendor_contact_number': contactNumber.value.toString(),
      'vendor_email': vendorEmailController.value.text.toString(),
      'invoice_number': invoiceNumberController.value.text.toString(),
      'warranty_details': warrantyDetailsController.value.text.toString(),
      'operational_status': operationalStatus.value.toLowerCase(),
      'last_updated': lastUpdatedController.value.text.toString(),
      'condition': conditionController.value.text.toString(),
      'comments': commentsNotesController.value.text.toString(),
      'insurance_provider': insuranceProviderController.value.text.toString(),
      'insurance_policy_number':
          insurancePolicyNumberController.value.text.toString(),
      'insurance_expiry_date':
          insuranceExpiryDateController.value.text.toString(),
    };
    _api.postAddAsset(data).then((value) {
      EasyLoading.dismiss();
      print('<><> 1');
      if (value['status'] == 0) {
        print('<><> 2');
        // Utils.snackBar('Error', value['message']);
      } else {
        print('<><> 3');
        Utils.isCheck = true;
        Utils.snackBar('Success', 'Asset created successfully');
        final assetListViewModel = Get.put(AssetListViewModel());
        assetListViewModel.getAssetList();
        Get.until((route) => Get.currentRoute == RouteName.assetListScreen);
      }
    }).onError((error, stackTrace) {
      print('<><> 4');
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
