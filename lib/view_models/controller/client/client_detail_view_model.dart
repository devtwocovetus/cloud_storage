import 'package:cold_storage_flutter/models/client/client_details_model.dart';
import 'package:cold_storage_flutter/repository/client_repository/client_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/client/client_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

class ClientDetailViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = ClientRepository();
  final accoutNameController = TextEditingController().obs;
  final locationController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final accountNameFocusNode = FocusNode().obs;
  final locationFocusNode = FocusNode().obs;
  final addressFocusNode = FocusNode().obs;
  final phoneFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;

  RxString clientId = ''.obs;
  RxString clientIsRequest = ''.obs;
  RxString requestSent = ''.obs;
  RxString outgoingRequestAccepted = ''.obs;
  
  RxString requestIncoming = ''.obs;
  RxString comeFrom = ''.obs;
  RxString incomingRequestAccepted = ''.obs;

  RxString clientIsManual = ''.obs;
  RxString pocPersonName = ''.obs;
  RxString pocPersonEmail = ''.obs;
  RxString pocPersonContactNumber = ''.obs;
  RxString relationId = ''.obs;
  RxInt isVendor = 0.obs;
  RxInt isCustomer = 0.obs;
  RxList<ClientEntityList>? clientEntityList = <ClientEntityList>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      clientId.value = argumentData[0]['clientId'];
      clientIsRequest.value = argumentData[0]['clientIsRequest'];
      clientIsManual.value = argumentData[0]['clientIsManual'];
      requestSent.value = argumentData[0]['requestSent'];
      outgoingRequestAccepted.value =
          argumentData[0]['outgoingRequestAccepted'];
      requestIncoming.value =
          argumentData[0]['requestIncoming'];
      incomingRequestAccepted.value =
          argumentData[0]['incomingRequestAccepted'];
      comeFrom.value =
          argumentData[0]['from'];
    }
    getClientDetails();
    super.onInit();
  }

  void getClientDetails() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.getClientDetails(clientId.value.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        ClientDetailsModel clientDetailsModel =
            ClientDetailsModel.fromJson(value);
        clientEntityList?.value = clientDetailsModel.data!.clientEntityList!
            .map((data) => data)
            .toList();
        accoutNameController.value.text = Utils.textCapitalizationString(
            clientDetailsModel.data!.clientData!.name.toString());
        locationController.value.text =
            '${Utils.textCapitalizationString(clientDetailsModel.data!.clientData!.city.toString())}, ${Utils.textCapitalizationString(clientDetailsModel.data!.clientData!.state.toString())}, ${Utils.textCapitalizationString(clientDetailsModel.data!.clientData!.country.toString())}';
        addressController.value.text =
            '${Utils.textCapitalizationString(clientDetailsModel.data!.clientData!.street1.toString())}, ${Utils.textCapitalizationString(clientDetailsModel.data!.clientData!.city.toString())}, ${Utils.textCapitalizationString(clientDetailsModel.data!.clientData!.state.toString())}, ${Utils.textCapitalizationString(clientDetailsModel.data!.clientData!.country.toString())}, ${Utils.textCapitalizationString(clientDetailsModel.data!.clientData!.postalCode.toString())}';
        phoneController.value.text =
            clientDetailsModel.data!.clientData!.contactNumber.toString();
        emailController.value.text =
            clientDetailsModel.data!.clientData!.email.toString();

        pocPersonName.value = Utils.textCapitalizationString(
            clientDetailsModel.data!.clientData!.pocPersonName.toString());
        pocPersonEmail.value = Utils.textCapitalizationString(
            clientDetailsModel.data!.clientData!.pocPersonEmail.toString());
        pocPersonContactNumber.value = Utils.textCapitalizationString(
            clientDetailsModel.data!.clientData!.pocPersonContactNumber
                .toString());
        relationId.value = clientDetailsModel.data!.relationId.toString();

        if (clientDetailsModel.data!.clientData!.userType == '0') {
          isVendor.value = 0;
          isCustomer.value = 0;
        } else if (clientDetailsModel.data!.clientData!.userType == '3') {
          isVendor.value = 1;
          isCustomer.value = 1;
        } else if (clientDetailsModel.data!.clientData!.userType == '2') {
          isVendor.value = 1;
          isCustomer.value = 0;
        } else if (clientDetailsModel.data!.clientData!.userType == '1') {
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
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    Map data = {
      'relation_id': relationId.value,
      'user_type': mStrUserType
    };
    _api.updateRelationClient(data,clientId.value.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Get.delete<ClientDetailViewModel>();
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

  void requestAccept() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    Map data = {'relation_id': relationId.value.toString(), 'accepted': '1'};
    _api.requestAcceptClientApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Login', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Success', 'Request accept successfully');
        if(comeFrom.value == 'Normal'){
 final clientListViewModel = Get.put(ClientListViewModel());
        clientListViewModel.getClientList();
        Get.until((route) => Get.currentRoute == RouteName.clientListScreen);
        }else{
          Get.offAllNamed(RouteName.homeScreenView,
                                arguments: []);
        }
       
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void requestDeclined() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    Map data = {'relation_id': relationId.value.toString(), 'accepted': '2'};
    _api.requestDeclinedClientApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Login', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Success', 'Request declined successfully');
          if(comeFrom.value == 'Normal'){
  final clientListViewModel = Get.put(ClientListViewModel());
        clientListViewModel.getClientList();
        Get.until((route) => Get.currentRoute == RouteName.clientListScreen);
          }else{
            Get.offAllNamed(RouteName.homeScreenView,
                                arguments: []);
          }
      
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
