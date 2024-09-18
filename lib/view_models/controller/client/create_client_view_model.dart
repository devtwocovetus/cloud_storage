
import 'package:cold_storage_flutter/models/account/account_create_model.dart';
import 'package:cold_storage_flutter/models/account/timezone_model.dart';
import 'package:cold_storage_flutter/models/account/unit_model.dart';
import 'package:cold_storage_flutter/repository/client_repository/client_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/client/client_list_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CreateClientViewModel extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
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
    pocContactNumber = '${pocCountryCode.value}${pocContactNumberController.value.text}';
     isLoading.value = true;
     EasyLoading.show(status: 'loading...');
     Map data = {
       'name': clientNameController.value.text,
       'email': emailController.value.text,
      'contact_number': contactNumber.toString(),
      'user_type': mStrUserType,
      'street1': streetOneController.value.text,
      'street2': streetTwoController.value.text,
      'country': countryController.value.text,
      'state': stateController.value.text,
      'city': cityController.value.text,
      'postal_code': postalCodeController.value.text,
      'points_of_contact': isPocChecked.value ? '1' : '0',
      'poc_person_name': pocContactNameController.value.text,
      'poc_person_email': pocContactEmailController.value.text,
      'poc_person_contact_number': pocContactNumber,
      'status': '1',
     };
     _api.createClientApi(data).then((value) {
       isLoading.value = false;
       EasyLoading.dismiss();
       if (value['status'] == 0) {
         // Utils.snackBar('Error', value['message']);
       } else {
         Get.delete<CreateClientViewModel>();
         Utils.isCheck = true;
         Utils.snackBar('Success', 'Client created successfully');
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
}
