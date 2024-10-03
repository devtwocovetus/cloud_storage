import 'package:cold_storage_flutter/models/notification/notification_list_model.dart';
import 'package:cold_storage_flutter/repository/notification_repository/notification_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class NotificationListViewModel extends GetxController{
  final _api = NotificationRepository();

  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;
  RxString clientId = ''.obs;

  @override
  void onInit() {
    getNotificationList();
    super.onInit();
  }

  void getNotificationList() {
    EasyLoading.show(status: 'loading...');
    _api.getNotificationListAPi().then((value) {
      print('<><><>@@@ ${value.toString()}');
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        NotificationListModel notificationListModel = NotificationListModel.fromJson(value);
        notificationList.value = notificationListModel.data!.map((e) => e,).toList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}