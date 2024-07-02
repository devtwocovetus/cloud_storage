import 'package:cold_storage_flutter/models/user/userrole_model.dart';
import 'package:cold_storage_flutter/repository/user_repository/user_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user/userlist_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
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
  RxString logoUrl = ''.obs;
  final userListViewModel = Get.put(UserlistViewModel());
  var isLoading = true.obs;

  @override
  void onInit() {
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });

    print('<><><> ${logoUrl.value}');
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

  Future<void> createUser()  async {
    int indexUserRole = userRoleList.indexOf(userRoleType.toString());
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'name': userNameController.value.text,
      'email': emailController.value.text,
      'contact_number': contactNumber.value.toString(),
      'status': isActive.value ? '1' : '0',
      'role': userRoleListId[indexUserRole].toString(),
    };
    _api.createUserApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      printWrapped('<><><>## ${value.toString()}'); 

      if (value['status'] == 0) {
        Utils.snackBar('Error', value['message']);
      } else {
        Utils.snackBar('Account', 'Account created successfully');
        userListViewModel.getUserList();
       
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
}
