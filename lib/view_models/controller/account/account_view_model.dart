import 'package:cold_storage_flutter/models/account/account_create_model.dart';
import 'package:cold_storage_flutter/models/account/timezone_model.dart';
import 'package:cold_storage_flutter/models/account/unit_model.dart';
import 'package:cold_storage_flutter/repository/account_repository/account_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class AccountViewModel extends GetxController {
  final _api = AccountRepository();

  final accountNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final streetOneController = TextEditingController().obs;
  final streetTwoController = TextEditingController().obs;
  final countryController = TextEditingController().obs;
  final stateController = TextEditingController().obs;
  final cityController = TextEditingController().obs;
  final postalCodeController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;



  final streetOneBillingController = TextEditingController().obs;
  final streetTwoBillingController = TextEditingController().obs;
  final countryBillingController = TextEditingController().obs;
  final stateBillingController = TextEditingController().obs;
  final cityBillingController = TextEditingController().obs;
  final postalCodeBillingController = TextEditingController().obs;


  final RxString countryCode = ''.obs;

  final accountNameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final streetOneFocusNode = FocusNode().obs;
  final streetTwoFocusNode = FocusNode().obs;
  final countryFocusNode = FocusNode().obs;
  final stateFocusNode = FocusNode().obs;
  final cityFocusNode = FocusNode().obs;
  final postalFocusNode = FocusNode().obs;
  final addressFocusNode = FocusNode().obs;
  final descriptionFocusNode = FocusNode().obs;

  final streetOneBillingFocusNode = FocusNode().obs;
  final streetTwoBillingFocusNode = FocusNode().obs;
  final countryBillingFocusNode = FocusNode().obs;
  final stateBillingFocusNode = FocusNode().obs;
  final cityBillingFocusNode = FocusNode().obs;
  final postalBillingFocusNode = FocusNode().obs;

  RxString defaultLanguage = ''.obs;
  RxString timeZone = ''.obs;
  RxBool isCheckedBilling = false.obs;
  RxString imageBase64 = ''.obs;
  RxString imageName = 'Upload Logo'.obs;
  String? contactNumber;

  var unitList = <String>[].obs;
  var unitListId = <int?>[].obs;
  var timeZoneList = <String>[].obs;
  var timeZoneListId = <int?>[].obs;
  var isLoading = true.obs;
  late i18n.Translations translation;

  @override
  void onInit() {
    getUnit();
    getTimeZone();
    super.onInit();
  }
  @override
  void onReady() {
    translation = i18n.Translations.of(Get.context!);
    super.onReady();
  }

  void submitAccountForm() {
    UserPreference userPreference = UserPreference();
    int indexUnit = unitList.indexOf('Imperial');
    int indexTime = timeZoneList.indexOf(timeZone.toString());
    contactNumber = '${countryCode.value}${phoneNumberController.value.text}';
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    Map data = {
      'name': Utils.textCapitalizationString(accountNameController.value.text),
      'email': emailController.value.text,
      'contact_number': contactNumber.toString(),
      'street1': Utils.textCapitalizationString(streetOneController.value.text),
      'street2': Utils.textCapitalizationString(streetTwoController.value.text),
      'country': Utils.textCapitalizationString(countryController.value.text),
      'state': Utils.textCapitalizationString(stateController.value.text),
      'city': Utils.textCapitalizationString(cityController.value.text),
      'postal_code': postalCodeController.value.text,
      'different_billing_address': isCheckedBilling.value ? '1' : '0',
      'billing_address_street1': Utils.textCapitalizationString(streetOneBillingController.value.text),
      'billing_address_street2': Utils.textCapitalizationString(streetTwoBillingController.value.text),
      'billing_address_country': Utils.textCapitalizationString(countryBillingController.value.text),
      'billing_address_state': Utils.textCapitalizationString(stateBillingController.value.text),
      'billing_address_city': Utils.textCapitalizationString(cityBillingController.value.text),
      'billing_address_postal_code': postalCodeBillingController.value.text,
      'default_language': 'en',
      'timezone': timeZoneListId[indexTime].toString(),
      'select_unit': unitListId[indexUnit].toString(),
      'description':Utils.textCapitalizationString(descriptionController.value.text),
      'logo': imageBase64.toString(),
      'status': '1',
    };
    _api.accountSubmitApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        AccountCreateModel accountCreateModel =
            AccountCreateModel.fromJson(value);
        // if (accountCreateModel.data!.account!.logo!.isNotEmpty) {
        //   userPreference
        //       .saveLogo(accountCreateModel.data!.account!.logo.toString());
        // }
        userPreference.updateCurrentAccountStatus(4);
        Get.delete<AccountViewModel>();
        Get.offAllNamed(RouteName.takeSubscriptionView)!.then((value) {});
        Utils.snackBar(t.account, t.account_created_success_text);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void getTimeZone() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.timeZonesApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        TimeZoneModel timeZoneModel = TimeZoneModel.fromJson(value);
        timeZoneList.value =
            timeZoneModel.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
        timeZoneListId.value =
            timeZoneModel.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void getUnit() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.unitApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        UnitModel unitModel = UnitModel.fromJson(value);
        unitList.value = unitModel.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
        unitListId.value = unitModel.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.isCheck = true;
      Utils.snackBar(t.error_text, error.toString());
    });
  }
}
