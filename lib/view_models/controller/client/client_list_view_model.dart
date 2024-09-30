import 'package:cold_storage_flutter/models/client/client_list_model.dart';
import 'package:cold_storage_flutter/repository/client_repository/client_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ClientListViewModel extends GetxController {
  final _api = ClientRepository();

  RxList<Client>? clientList = <Client>[].obs;
  RxList<Client>? clientListForSearch = <Client>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getClientList();
    super.onInit();
  }

  void searchFilter(String searchText) {
    List<Client>? results = [];
    if(searchText.isEmpty) {
      results = clientListForSearch?.value;
      print(results);
    } else {
      results = clientListForSearch?.value.where((element) => element.name!.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
    clientList?.value = results ?? [];
  }

void getClientList() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
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
      Utils.snackBar('Error', error.toString());
    });
  }
}
