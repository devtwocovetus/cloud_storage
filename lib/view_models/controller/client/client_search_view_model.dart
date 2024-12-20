import 'dart:developer';

import 'package:cold_storage_flutter/models/client/client_search_list_model.dart';
import 'package:cold_storage_flutter/repository/client_repository/client_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/client/client_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

import '../../../models/client/global_client_list_model.dart';

class ClientSearchViewModel extends GetxController {
  final _api = ClientRepository();
  final GlobalKey<SliderDrawerState> materialOutDrawerKey =
      GlobalKey<SliderDrawerState>();

  RxList<Search>? clientList = <Search>[].obs;
  RxList<Client> globalClientList = <Client>[].obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  final searchController = TextEditingController().obs;

  final RxInt count = 4.obs;
  RxBool isData = true.obs;
  RxBool isSearchDone = false.obs;
  RxInt isVendor = 0.obs;
  RxInt isCustomer = 0.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getClientList('');
    super.onInit();
  }


  void getClientList(String request) {
    isSearchDone.value = false;
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.getGlobalClientList(request).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        isSearchDone.value = true;
        globalClientList.value = <Client>[].obs;
      } else {
        isSearchDone.value = true;
        GlobalClientListModel clientListModel = GlobalClientListModel.fromJson(value);
        globalClientList.value = clientListModel.clientList!.map((data) => data).toList();

        log('-------------clientList--------- : ${globalClientList.value.toString()}');
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error, error.toString());
    });
  }


  void getClientListOld(String request) {
    isSearchDone.value = false;
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.searchClient(request).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        isSearchDone.value = true;
        clientList?.value = <Search>[].obs;
      } else {
        isSearchDone.value = true;
        ClientSearchListModel clientListModel =
            ClientSearchListModel.fromJson(value);
        clientList?.value = clientListModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error, error.toString());
    });
  }

  void sendRequestClient(String requestId) {
    String mStrUserType = '0';

    if (isVendor.value == 0 && isCustomer.value == 0) {
      mStrUserType = '0';
    } else if (isVendor.value == 1 && isCustomer.value == 1) {
      mStrUserType = '3';
    } else if (isVendor.value == 1 && isCustomer.value == 0) {
      mStrUserType = '2';
    } else if (isVendor.value == 0 && isCustomer.value == 1) {
      mStrUserType = '1';
    }

    Map data = {
      'receiver_account_id': requestId,
      'user_type': mStrUserType
    };
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.sendRequestClientApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        Utils.isCheck = true;
        Utils.snackBar(t.success_text, t.request_sent_success_text);
        getClientList(searchController.value.text);
        final clientListViewModel = Get.put(ClientListViewModel());
        clientListViewModel.getClientList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error, error.toString());
    });
  }
}
