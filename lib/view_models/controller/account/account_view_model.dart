import 'dart:convert';

import 'package:cold_storage_flutter/models/account/timezone_model.dart';
import 'package:cold_storage_flutter/models/account/unit_model.dart';
import 'package:cold_storage_flutter/repository/account_repository/account_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AccountViewModel extends GetxController  {
  final _api = AccountRepository();
  UserPreference userPreference = UserPreference();
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  RxList<String?> timeZoneList = <String>[].obs;
  RxBool loading = false.obs;

  RxList<String?> unit = <String>[].obs;
  RxList<String?> unitRx = <String>[].obs;


@override
  void onInit() {
    getUnit();
    super.onInit();
  }
  

  void getTimeZone() {
    loading.value = true;
    EasyLoading.show(status: 'loading...');
  
    _api.timeZonesApi().then((value) {
      loading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.snackBar('Error', value['message']);
      } else {
        TimeZoneModel timeZoneModel = TimeZoneModel.fromJson(value);
        timeZoneList.value = timeZoneModel.data?.map((data) => data.name).toList() ?? [];
        update();
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }


void getUnit()  {
    loading.value = true;
    EasyLoading.show(status: 'loading...');
  
    _api.unitApi().then((value) {
      loading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.snackBar('Error', value['message']);
      } else {
        print('@@@@<><><> call');
        UnitModel unitModel = UnitModel.fromJson(value);
         print('@@@@<><><> call 2');
        unit.value = unitModel.data?.map((data) => data.name).toList() ?? [];
        print('@@@@<><><> ${unit.length}');
        update();
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

}
