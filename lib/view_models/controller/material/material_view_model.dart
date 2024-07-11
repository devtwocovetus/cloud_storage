import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../user_preference/user_prefrence_view_model.dart';

class MaterialViewModel extends GetxController{

  RxString logoUrl = ''.obs;
  TextEditingController storageNameC = TextEditingController();
  TextEditingController ownerNameC = TextEditingController();

  @override
  void onInit() {
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
      // logoUrl.value = 'https://img.freepik.com/free-vector/gradient-logo-with-abstract-shape_23-2148216799.jpg';
    });
    userPreference.getUserName().then((value) {
      print("abc<>< : ${value.toString()}");
      ownerNameC.text = value.toString();
      print("abc<>< : ${ownerNameC.text}");
    });
    super.onInit();
  }
}