import 'package:cold_storage_flutter/models/user/userrole_model.dart';
import 'package:cold_storage_flutter/repository/user_repository/user_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user/userlist_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CreateusersettingViewModel extends GetxController {
  final _api = UserRepository();


  RxString userRoleType = ''.obs;
  var userRoleList = <String>[].obs;
  var userRoleListId = <int?>[].obs;
  final emailController = TextEditingController().obs;
  final userNameController = TextEditingController().obs;
    final phoneNumberController = TextEditingController().obs;
  final RxString countryCode = ''.obs;

  final emailFocusNode = FocusNode().obs;
  final userNameFocusNode = FocusNode().obs;

  RxString imageBase64 = ''.obs;
  RxString imageFilePath = ''.obs;
  RxBool isActive = /*false.obs*/true.obs;
  RxString logoUrl = ''.obs;
  final userListViewModel = Get.put(UserlistViewModel());
  var isLoading = true.obs;
  String? contactNumber;

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
        // Utils.snackBar('Error', value['message']);
      } else {
        UserRole userRole = UserRole.fromJson(value);
        userRoleList.value = userRole.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
        userRoleListId.value = userRole.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future<void> createUser()  async {
    contactNumber = '${countryCode.value}${phoneNumberController.value.text}';
    int indexUserRole = userRoleList.indexOf(userRoleType.toString());
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'name': userNameController.value.text,
      'email': emailController.value.text,
      'contact_number': contactNumber.toString(),
      'status': isActive.value ? '1' : '0',
      'role': userRoleListId[indexUserRole].toString(),
    };
    _api.createUserApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      printWrapped('<><><>## ${value.toString()}'); 

      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Success', 'User created successfully');
        userListViewModel.getUserList();
       Get.until((route) => Get.currentRoute == RouteName.userListSetting);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
       Utils.isCheck = true;
      Utils.snackBar('Error', error.toString());
    });
  }

  void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
}
