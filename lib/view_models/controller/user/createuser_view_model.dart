import 'package:cold_storage_flutter/models/user/userrole_model.dart';
import 'package:cold_storage_flutter/repository/user_repository/user_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CreateuserViewModel extends GetxController {
  final _api = UserRepository();

  RxString contactNumber = ''.obs;
  RxString userRoleType = ''.obs;
  var userRoleList = <String?>[].obs;
  var userRoleListId = <int?>[].obs;
  final emailController = TextEditingController().obs;
  final userNameController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final userNameFocusNode = FocusNode().obs;

  RxString imageBase64 = ''.obs;
  RxString imageFilePath = ''.obs;
  RxBool isActive = false.obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    getUserRole();
    super.onInit();
  }

  void getUserRole() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.userRoleListApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.snackBar('Error', value['message']);
      } else {
        UserRole userRole = UserRole.fromJson(value);
        userRoleList.value = userRole.data!.map((data) => data.name).toList();
        userRoleListId.value = userRole.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void createUser() {
    int indexUserRole = userRoleList.indexOf(userRoleType.toString());
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'name': userNameController.value.text,
      'email': emailController.value.text,
      'contact_number': contactNumber.value.toString(),
      'status': isActive.value ? '1':'0',
      'role': userRoleListId[indexUserRole].toString(),
    };
    _api.createUserApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.snackBar('Error', value['message']);
      } else {
  
        Get.delete<CreateuserViewModel>();
        //Get.toNamed(RouteName.takeSubscriptionView)!.then((value) {});
        Utils.snackBar('Account', 'Account created successfully');
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
