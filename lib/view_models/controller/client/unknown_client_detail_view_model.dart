import 'package:cold_storage_flutter/i10n/strings.g.dart';
import 'package:cold_storage_flutter/repository/client_repository/client_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cold_storage_flutter/models/client/global_client_list_model.dart';

import 'client_list_view_model.dart';

class UnknownClientDetailViewModel extends GetxController{

  dynamic argumentData = Get.arguments;
  final _api = ClientRepository();

  final accountNameController = TextEditingController().obs;
  final locationController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final accountNameFocusNode = FocusNode().obs;
  final locationFocusNode = FocusNode().obs;
  final addressFocusNode = FocusNode().obs;
  final phoneFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;

  RxInt isVendor = 0.obs;
  RxInt isCustomer = 0.obs;

  RxString clientId = ''.obs;
  Rx<Client> clientModel = Client().obs;
  RxBool canSendRequest = false.obs;
  RxBool isLoading = true.obs;
  // Rx<ClientDetailsModel> clientDetails = ClientDetailsModel().obs;

  @override
  void onInit(){
    if(argumentData != null){
      isLoading.value = true;
      EasyLoading.show(status: t.loading);

      clientModel.value = argumentData[0]['client_model'];
      print('clientId.value : ${clientModel.value}');
      // getClientDetails();
      accountNameController.value.text = clientModel.value.name ?? '';
      locationController.value.text =
      '${Utils.textCapitalizationString(clientModel.value.city.toString())}, ${Utils.textCapitalizationString(clientModel.value.state.toString())}, ${Utils.textCapitalizationString(clientModel.value.country.toString())}';

      // '${Utils.textCapitalizationString(clientModel.value.street1.toString())}, ${Utils.textCapitalizationString(clientModel.value.city.toString())}, ${Utils.textCapitalizationString(clientModel.value.state.toString())}, ${Utils.textCapitalizationString(clientModel.value.country.toString())}';

      addressController.value.text =
      '${Utils.textCapitalizationString(clientModel.value.street1.toString())}, ${Utils.textCapitalizationString(clientModel.value.city.toString())}, ${Utils.textCapitalizationString(clientModel.value.state.toString())}, ${Utils.textCapitalizationString(clientModel.value.country.toString())}, ${Utils.textCapitalizationString(clientModel.value.postalCode.toString())}';
      phoneController.value.text = clientModel.value.contactNumber ?? '';
      emailController.value.text = clientModel.value.email ?? '';

      isLoading.value = false;
      EasyLoading.dismiss();
    }
    super.onInit();
  }

  sendRequestUpdate() {
    if (isVendor.value == 1 || isCustomer.value == 1) {
      canSendRequest.value = true;
    } else {
      canSendRequest.value = false;
    }
  }

  void sendRequestClient() {
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

    Map data = {
      'receiver_account_id': clientModel.value.id.toString(),
      'user_type': mStrUserType
    };
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.sendRequestClientApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        Utils.isCheck = true;
        Utils.snackBar(t.success_text, t.request_sent_success_text);
        // getClientList(searchController.value.text);
        final clientListViewModel = Get.put(ClientListViewModel());
        clientListViewModel.getClientList();
        Get.until((route) => Get.currentRoute == RouteName.clientListScreen);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error, error.toString());
    });
  }

}