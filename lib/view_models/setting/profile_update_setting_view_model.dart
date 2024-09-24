import 'dart:developer';

import 'package:cold_storage_flutter/extensions/extension.dart';
import 'package:cold_storage_flutter/models/profile/update_profile_model.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../repository/profile_repository/profile_repository.dart';

class ProfileUpdateSettingViewModel extends GetxController {
  final _api = ProfileRepository();

  UserPreference userPreference = UserPreference();

  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;
  final RxString countryCode = ''.obs;

  final firstNameFocusNode = FocusNode().obs;
  final lastNameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  String? contactNumber;

  RxBool loading = false.obs;

  RxString imageBase64 = ''.obs;
  RxString imageFilePath = ''.obs;
  RxString imageUrl = ''.obs;
  String userId = '';

  @override
  Future<void> onInit() async {
    UserPreference userPreference = UserPreference();
    firstNameController.value.text = UserPreference.userFirstName.value.toCapitalize();
    lastNameController.value.text = UserPreference.userLastName.value.toCapitalize();
    emailController.value.text = UserPreference.profileUserEmail.value;
    imageUrl.value = UserPreference.profileLogo.value;
    log('responseresponse : ${UserPreference.profileLogo.value}');
    String phone = UserPreference.userPhoneNumber.value;
    if(phone.isNotEmpty || phone.length > 9){
      int rem = phone.length - 10;
      phoneNumberController.value.text = phone.substring(rem,phone.length);
      countryCode.value = phone.substring(0,rem);
    }
    int id = await userPreference.getUserId() ?? 0;
    userId = id != 0 ? id.toString() : '';
    super.onInit();
  }

  void submitProfileForm() {
    EasyLoading.show(status: 'loading...');
    contactNumber = '${countryCode.value}${phoneNumberController.value.text}';
    Map data = {
      "first_name" : Utils.textCapitalizationString(firstNameController.value.text.toString()),
      "last_name" : Utils.textCapitalizationString(lastNameController.value.text.toString()),
      "email" : emailController.value.text.toString(),
      "contact_number": contactNumber.toString(),
      "default_language": "en",
      'profile_image': imageBase64.value.toString()
    };
    _api.profileUpdateApi(data,userId).then((value) {
      if (value['status'] == 0) {

      } else {
        UpdateProfileModel profileData = UpdateProfileModel.fromJson(value);
        userPreference.saveUserOnProfileUpdate(profileData);
        EasyLoading.dismiss();
        Get.delete<ProfileUpdateSettingViewModel>();
        Get.offAllNamed(RouteName.homeScreenView)!.then((value) {});
        Utils.snackBar('Account', 'Profile updated successfully');
      }
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
    EasyLoading.dismiss();
  }
}
