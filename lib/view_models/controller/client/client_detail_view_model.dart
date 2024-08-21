import 'package:cold_storage_flutter/models/client/client_details_model.dart';
import 'package:cold_storage_flutter/repository/client_repository/client_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/client/client_list_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

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

  RxString logoUrl = ''.obs;
  RxString clientId = ''.obs;
  RxString clientIsRequest = ''.obs;
  RxString clientIsManual = ''.obs;
  RxString pocPersonName = ''.obs;
  RxString pocPersonEmail = ''.obs;
  RxString pocPersonContactNumber = ''.obs;
  RxString relationId = ''.obs;
  RxList<ClientEntityList>? clientEntityList = <ClientEntityList>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      clientId.value = argumentData[0]['clientId'];
      clientIsRequest.value = argumentData[0]['clientIsRequest'];
      clientIsManual.value = argumentData[0]['clientIsManual'];
    }
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getClientDetails();
    super.onInit();
  }

  void getClientDetails() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
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
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void requestAccept() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {'relation_id': relationId.value.toString(), 'accepted': '1'};
    _api.requestAcceptClientApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Login', value['message']);
      } else {
        Utils.snackBar('Success', 'Request accept successfully');
        final clientListViewModel = Get.put(ClientListViewModel());
        clientListViewModel.getClientList();
         Get.until(
            (route) => Get.currentRoute == RouteName.clientListScreen);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void requestDeclined() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {'relation_id': relationId.value.toString(), 'accepted': '2'};
    _api.requestDeclinedClientApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Login', value['message']);
      } else {
        Utils.snackBar('Success', 'Request declined successfully');
        final clientListViewModel = Get.put(ClientListViewModel());
        clientListViewModel.getClientList();
         Get.until(
            (route) => Get.currentRoute == RouteName.clientListScreen);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
