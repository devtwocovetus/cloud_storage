import 'package:cold_storage_flutter/models/material/measurement_unit_mou.dart';
import 'package:cold_storage_flutter/models/material/measurement_units_type.dart';
import 'package:cold_storage_flutter/repository/material_repository/material_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

class UnitWidgetViewModel extends GetxController {
  final _api = MaterialRepository();

  var unitTypeList = <String>[].obs;
  var mouList = <String>[].obs;
  var mouListId = <int?>[].obs;
  final RxString unitType = ''.obs;
  final RxString unitMou = ''.obs;

  final emailController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getMaterialUnitType();
    super.onInit();
  }

  void getMaterialUnitType() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.unitTypeListApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MeasurementUnitsType measurementUnitsType =
            MeasurementUnitsType.fromJson(value);
            print('<><><>#### ${measurementUnitsType.toString()}');
        unitTypeList.value =
            measurementUnitsType.data!.map((data) => Utils.textCapitalizationString(data.unitType!)).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void getMouList(String unitType) {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    Map data = {'unit_type': unitType};
    _api.unitMouListApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Login', value['message']);
      } else {
        MeasurementUnitMou measurementUnitmou =
            MeasurementUnitMou.fromJson(value);
        mouList.value =
            measurementUnitmou.data!.map((data) => Utils.textCapitalizationString(data.unitName!)).toList();
        mouListId.value =
            measurementUnitmou.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  // Future<void> createUser()  async {
  //   contactNumber = '${countryCode.value}${phoneNumberController.value.text}';
  //   int indexUserRole = userRoleList.indexOf(userRoleType.toString());
  //   isLoading.value = true;
  //   EasyLoading.show(status: 'loading...');
  //   Map data = {
  //     'name': userNameController.value.text,
  //     'email': emailController.value.text,
  //     'contact_number': contactNumber.toString(),
  //     'status': isActive.value ? '1' : '0',
  //     'role': userRoleListId[indexUserRole].toString(),
  //   };
  //   _api.createUserApi(data).then((value) {
  //     isLoading.value = false;
  //     EasyLoading.dismiss();
  //     printWrapped('<><><>## ${value.toString()}');

  //     if (value['status'] == 0) {
  //       // Utils.snackBar('Error', value['message']);
  //     } else {
  //       Utils.isCheck = true;
  //       Utils.snackBar('Account', 'Account created successfully');
  //       userListViewModel.getUserList();
  //      Get.until((route) => Get.currentRoute == RouteName.userListView);
  //     }
  //   }).onError((error, stackTrace) {
  //     isLoading.value = false;
  //     EasyLoading.dismiss();
  //      Utils.isCheck = true;
  //     Utils.snackBar('Error', error.toString());
  //   });
  // }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
