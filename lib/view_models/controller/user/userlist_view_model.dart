import 'package:cold_storage_flutter/models/home/user_list_model.dart';
import 'package:cold_storage_flutter/repository/user_repository/user_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class UserlistViewModel extends GetxController {
  final _api = UserRepository();

  RxInt userLeftCount = 0.obs;
  RxString userRoleType = ''.obs;
  RxString logoUrl = ''.obs;
  RxList<UsersList>? userList = <UsersList>[].obs;

  
  var isLoading = true.obs;

  @override
  void onInit() {
     UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getUserList();
    super.onInit();
  }

  void getUserList() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.userListApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.snackBar('Error', value['message']);
      } else {
        UserListModel userListModel = UserListModel.fromJson(value);
        userList?.value = userListModel.data!.users!.map((data) => data).toList();
        userLeftCount.value = userListModel.data!.commonDetails!.usersLeftCount!;
        
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
