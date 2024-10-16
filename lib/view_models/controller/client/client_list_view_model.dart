import 'package:cold_storage_flutter/models/client/client_list_model.dart';
import 'package:cold_storage_flutter/repository/client_repository/client_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

class ClientListViewModel extends GetxController {
  dynamic argumentData = Get.arguments;
  final _api = ClientRepository();

  RxList<Client>? clientList = <Client>[].obs;
  RxList<Client>? clientListForSearch = <Client>[].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  var isLoading = true.obs;
  RxString comeFrom = ''.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      comeFrom.value = argumentData[0]['from'];
    }
    getClientList();
    super.onInit();
  }

  void searchFilter(String searchText) {
    List<Client>? results = [];
    if (searchText.isEmpty) {
      results = clientListForSearch?.value;
      print(results);
    } else {
      results = clientListForSearch?.value
          .where((element) =>
              element.name!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
    clientList?.value = results ?? [];
  }

  void getClientList() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.getClient().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        ClientListModel clientListModel = ClientListModel.fromJson(value);
        clientList?.value = clientListModel.data!.map((data) => data).toList();
        clientListForSearch?.value = clientList!.value;
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error, error.toString());
    });
  }
}
