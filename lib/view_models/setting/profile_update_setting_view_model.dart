import 'dart:developer';

import 'package:cold_storage_flutter/extensions/extension.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';
import 'package:cold_storage_flutter/models/profile/update_profile_model.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../repository/profile_repository/profile_repository.dart';
import '../../i10n/strings.g.dart' as i18n;

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
  List<String> languageItems = ['English', 'Spanish'];
  RxString defaultLanguage = ''.obs;

  late i18n.Translations translation;

  @override
  void onReady() {
    translation = i18n.Translations.of(Get.context!);
    super.onReady();
  }



  @override
  Future<void> onInit() async {
    UserPreference userPreference = UserPreference();
    firstNameController.value.text = UserPreference.userFirstName.value.toCapitalize();
    lastNameController.value.text = UserPreference.userLastName.value.toCapitalize();
    emailController.value.text = UserPreference.profileUserEmail.value;
    imageUrl.value = UserPreference.profileLogo.value;
    defaultLanguage.value = UserPreference.appLanguage.value;
    print('<><><> ${defaultLanguage.value}');
    log('responseresponse : ${UserPreference.profileLogo.value}');
    String phone = UserPreference.userPhoneNumber.value;
    if(phone.isNotEmpty || phone.length > 9){
      int rem = phone.length - 10;
      phoneNumberController.value.text = phone.substring(rem,phone.length);
      countryCode.value = phone.substring(0,rem);
    }

    if(defaultLanguage.value == 'en'){
      defaultLanguage.value = 'English';
    }else {
      defaultLanguage.value = 'Spanish';
    }

    int id = await userPreference.getUserId() ?? 0;
    userId = id != 0 ? id.toString() : '';
    super.onInit();
  }

  void submitProfileForm() {
    EasyLoading.show(status: t.loading);
    contactNumber = '${countryCode.value}${phoneNumberController.value.text}';
    Map data = {
      "first_name" : Utils.textCapitalizationString(firstNameController.value.text.toString()),
      "last_name" : Utils.textCapitalizationString(lastNameController.value.text.toString()),
      "email" : emailController.value.text.toString(),
      "contact_number": '${contactNumber.toString()}',
      "default_language": defaultLanguage.value != 'English' ? 'es' : 'en',
      'profile_image': imageBase64.value.toString()
    };
    _api.profileUpdateApi(data,userId).then((value) {
      if (value['status'] == 0) {

      } else {
        UpdateProfileModel profileData = UpdateProfileModel.fromJson(value);
        userPreference.saveUserOnProfileUpdate(profileData);
        EasyLoading.dismiss();
        // translation = i18n.Translations.of(Get.context!).;
        Get.delete<ProfileUpdateSettingViewModel>();
        Get.offAllNamed(RouteName.homeScreenView)!.then((value) {});
        Utils.snackBar(i18n.Translations.of(Get.context!).account, i18n.Translations.of(Get.context!).profile_updated_success_text);
      }
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  
  }
}
