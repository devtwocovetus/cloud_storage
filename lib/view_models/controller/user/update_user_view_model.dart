import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cold_storage_flutter/data/network/dio_services/api_client.dart';
import 'package:cold_storage_flutter/data/network/dio_services/api_provider/user_provider.dart';
import 'package:cold_storage_flutter/models/home/user_list_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user/userlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/user/userrole_model.dart';
import '../../../repository/user_repository/user_repository.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../../setting/userlistsetting_view_model.dart';
import '../user_preference/user_prefrence_view_model.dart';

class UpdateUserViewModel extends GetxController{
  dynamic argumentData = Get.arguments;
  final _api = UserRepository();

  ///updation code will be 1 when updating from initial account setup
  String updationCode = '0';

  int userId = 0;
  var isLoading = true.obs;
  RxList<UserRole> userRoleList = <UserRole>[].obs;
  int userRoleId = 0;
  UserRole? userRole;
  final emailController = TextEditingController().obs;
  final userNameController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;
  final RxString countryCode = ''.obs;

  final emailFocusNode = FocusNode().obs;
  final userNameFocusNode = FocusNode().obs;

  RxString imageBase64 = ''.obs;
  RxString imageFilePath = ''.obs;
  RxBool isActive = false.obs;
  final userListViewModel = Get.put(UserlistsettingViewModel());
  String? contactNumber;

  final ImagePicker picker = ImagePicker();
  XFile? image;
  Map<String,dynamic> updatingUser = {};

  @override
  void onInit() {
    if (argumentData != null) {
      updationCode = argumentData['updation_code'] ?? '0';
      UsersList user = argumentData['user'];
      updatingUser = user.toJson();
      log('updatingUser : $updatingUser');
      print('<><>@@###  ${updatingUser.toString()}');
    }
    getUserRole();
    assignInitialValues();
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
        UserRoleModel userRoleModel = UserRoleModel.fromJson(value);
        userRoleList.value = userRoleModel.data!.map((e) => e,).toList();
        if(userRoleList.isNotEmpty){
          int id = int.parse(updatingUser['role'].toString().trim());
          int index = userRoleList.indexWhere((e) {
            return e.id == id.toInt();
          });
          userRole = userRoleList[index];
          log('manager?.value 1: $userRole');
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  assignInitialValues(){
    String phone = updatingUser['contact_number'] ?? '';
    int rem = phone.length - 10;
    phoneNumberController.value.text = phone.substring(rem,phone.length);
    countryCode.value = phone.substring(0,rem);
    emailController.value.text = updatingUser['email'];
    userNameController.value.text = updatingUser['name'];
    userRoleId = updatingUser['role'];
    userId = int.parse(updatingUser['id'].toString());
    isActive.value = int.parse(updatingUser['status']) != 0 ? true : false;
  }

  Future<void> imageBase64Convert() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      imageBase64.value = '';
      imageFilePath.value = '';
    } else {
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
      imageBase64.value = base64Image;
      imageFilePath.value = image!.path.toString();
    }
  }

  Future<void> updateUser()  async {
    contactNumber = '${countryCode.value}${phoneNumberController.value.text}';
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'name': userNameController.value.text,
      'email': emailController.value.text,
      'contact_number': contactNumber.toString(),
      'status': isActive.value ? '1' : '0',
      'role': userRoleId,
      'profile_image' : imageBase64.value.toString(),
    };
    DioClient client = DioClient();
    final api2 = UserProvider(client: client.init());
    api2.updateUserApi(data: data,userId: userId).then((value) {
      log('manager?.value : ${value.toString()}');
      isLoading.value = false;
      EasyLoading.dismiss();

      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Success', 'User updated successfully');
        if(updationCode != '0'){
          UserlistViewModel viewModel = Get.put(UserlistViewModel());
          viewModel.getUserList();
          Get.until((route) => Get.currentRoute == RouteName.userListView);
        }else{
          userListViewModel.getUserList();
          Get.until((route) => Get.currentRoute == RouteName.userListSetting);
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.isCheck = true;
      Utils.snackBar('Error', error.toString());
    });
  }
}