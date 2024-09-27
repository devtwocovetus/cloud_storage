import 'package:cold_storage_flutter/models/client/manual_client_details_model.dart';
import 'package:cold_storage_flutter/repository/client_repository/client_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/countries.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/client/client_list_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ManualClientDetailViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = ClientRepository();

  final clientNameController = TextEditingController().obs;
  final streetOneController = TextEditingController().obs;
  final streetTwoController = TextEditingController().obs;
  final countryController = TextEditingController().obs;
  final stateController = TextEditingController().obs;
  final cityController = TextEditingController().obs;
  final postalCodeController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;

  final pocContactNameController = TextEditingController().obs;
  final pocContactNumberController = TextEditingController().obs;
  final pocContactEmailController = TextEditingController().obs;

  final clientNameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final streetOneFocusNode = FocusNode().obs;
  final streetTwoFocusNode = FocusNode().obs;
  final countryFocusNode = FocusNode().obs;
  final stateFocusNode = FocusNode().obs;
  final cityFocusNode = FocusNode().obs;
  final postalFocusNode = FocusNode().obs;

  final phoneNumberFocusNode = FocusNode().obs;
  final pocContactNameFocusNode = FocusNode().obs;
  final pocContactNumberFocusNode = FocusNode().obs;
  final pocContactEmailFocusNode = FocusNode().obs;

  String? contactNumber;
  final RxString countryCode = ''.obs;

  String? pocContactNumber;
  final RxString pocCountryCode = ''.obs;

  RxBool isPocChecked = false.obs;
  RxInt isVendor = 0.obs;
  RxInt isCustomer = 0.obs;
  var isLoading = true.obs;
  RxString clientId = ''.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      clientId.value = argumentData[0]['clientId'];
    }
    getClientDetails();
    super.onInit();
  }

  void getClientDetails() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.getClientDetailsManual(clientId.value.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        ManualClientDetailsModel clientDetailsModel =
            ManualClientDetailsModel.fromJson(value);
        clientNameController.value.text = clientDetailsModel.data!.name ?? '';
        streetOneController.value.text = clientDetailsModel.data!.street1 ?? '';
        streetTwoController.value.text = clientDetailsModel.data!.street2 ?? '';
        countryController.value.text = clientDetailsModel.data!.country ?? '';
        stateController.value.text = clientDetailsModel.data!.state ?? '';
        cityController.value.text = clientDetailsModel.data!.city ?? '';

        postalCodeController.value.text =
            clientDetailsModel.data!.postalCode ?? '';
        emailController.value.text = clientDetailsModel.data!.email ?? '';
        pocContactNameController.value.text =
            clientDetailsModel.data!.pocPersonName ?? '';
        pocContactEmailController.value.text =
            clientDetailsModel.data!.pocPersonEmail ?? '';

        seperatePhoneAndDialCode(
            clientDetailsModel.data!.contactNumber ?? '', 0);
        seperatePhoneAndDialCode(
            clientDetailsModel.data!.pocPersonContactNumber ?? '', 1);

        if (clientDetailsModel.data!.pointsOfContact == '1') {
          isPocChecked.value = true;
        } else {
          isPocChecked.value = false;
        }
        if (clientDetailsModel.data!.userType == '0') {
          isVendor.value = 0;
          isCustomer.value = 0;
        } else if (clientDetailsModel.data!.userType == '3') {
          isVendor.value = 1;
          isCustomer.value = 1;
        } else if (clientDetailsModel.data!.userType == '2') {
          isVendor.value = 1;
          isCustomer.value = 0;
        } else if (clientDetailsModel.data!.userType == '1') {
          isVendor.value = 0;
          isCustomer.value = 1;
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void submitAccountForm() {
    String mStrUserType = '0';
    if (isVendor.value == 0 && isCustomer.value == 0) {
      mStrUserType = '0';
    } else if (isVendor.value == 1 && isCustomer.value == 1) {
      mStrUserType = '3';
    } else if (isVendor.value == 1 && isCustomer.value == 0) {
      mStrUserType = '2';
    } else if (isVendor.value == 0 && isCustomer.value == 1) {
      mStrUserType = '1';
    }
    contactNumber = '${countryCode.value}${phoneNumberController.value.text}';
    pocContactNumber =
        '${pocCountryCode.value}${pocContactNumberController.value.text}';
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'name': Utils.textCapitalizationString(clientNameController.value.text),
      'email': emailController.value.text,
      'contact_number': contactNumber.toString(),
      'user_type': mStrUserType,
      'street1': Utils.textCapitalizationString(streetOneController.value.text),
      'street2': Utils.textCapitalizationString(streetTwoController.value.text),
      'country': Utils.textCapitalizationString(countryController.value.text),
      'state': Utils.textCapitalizationString(stateController.value.text),
      'city': Utils.textCapitalizationString(cityController.value.text),
      'postal_code': postalCodeController.value.text,
      'points_of_contact': isPocChecked.value ? '1' : '0',
      'poc_person_name': Utils.textCapitalizationString(pocContactNameController.value.text),
      'poc_person_email': pocContactEmailController.value.text,
      'poc_person_contact_number': pocContactNumber,
      'status': '1',
    };
    _api.updateManualClient(data,clientId.value.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Get.delete<ManualClientDetailViewModel>();
        Utils.isCheck = true;
        Utils.snackBar('Success', 'Record updated successfully');
        final clientListViewModel = Get.put(ClientListViewModel());
        clientListViewModel.getClientList();
        Get.until((route) => Get.currentRoute == RouteName.clientListScreen);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  seperatePhoneAndDialCode(String textNumber, int op) {
    Map<String, String> foundedCountry = {};
    for (var country in Countries.allCountries) {
      String dialCode = country["dial_code"].toString();
      if (textNumber.contains(dialCode)) {
        foundedCountry = country;
      }
    }
    if (foundedCountry.isNotEmpty) {
      var dialCode = textNumber.substring(
        0,
        foundedCountry["dial_code"]!.length,
      );
      var newPhoneNumber = textNumber.substring(
        foundedCountry["dial_code"]!.length,
      );
      if (op == 0) {
        phoneNumberController.value.text = newPhoneNumber.toString();
      } else {
        pocContactNumberController.value.text = newPhoneNumber.toString();
      }
    }
  }
}
