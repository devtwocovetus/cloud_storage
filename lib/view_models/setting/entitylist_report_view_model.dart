import 'package:cold_storage_flutter/data/network/dio_services/api_client.dart';
import 'package:cold_storage_flutter/data/network/dio_services/api_provider/report_provider.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';
import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/models/entity/entity_reporting_list_model.dart';
import 'package:cold_storage_flutter/repository/entity_repository/entity_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EntitylistReportViewModel extends GetxController {
  final _api = EntityRepository();

  RxBool isCheckDaily = false.obs;

  RxList<EntityReport>? entityList = <EntityReport>[].obs;
  RxList<int>? listDaily = <int>[].obs;
  RxList<int>? listWeekly = <int>[].obs;
  RxList<int>? listMonthly = <int>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getEntityList();
    super.onInit();
  }

  void getEntityList() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.entityReportingCycleList().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        EntityReportingListModel entityReportingListModel =
            EntityReportingListModel.fromJson(value);
        entityList?.value =
            entityReportingListModel.data!.map((data) => data).toList();
        listDaily?.value = entityReportingListModel.data!
            .map((data) => data.reportingCycleIdDaily!)
            .toList();
        listWeekly?.value = entityReportingListModel.data!
            .map((data) => data.reportingCycleIdWeekly!)
            .toList();
        listMonthly?.value = entityReportingListModel.data!
            .map((data) => data.reportingCycleIdMonthly!)
            .toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void deleteEntity(String entityId, String entityType) {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.entityDelete(entityId, entityType).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar(t.success_text, t.record_delete_success_text);
        getEntityList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  Future<void> saveReport() async {
    List<Map<String, dynamic>> reportList = <Map<String, dynamic>>[];
    int index = 0;
    for (var i in entityList!) {
      Map<String, dynamic> watchList = {
        "entity_id": i.id.toString(),
        "entity_type_id": i.entityType.toString(),
        "reporting_cycle_id_daily": listDaily![index].toString(),
        "reporting_cycle_id_weekly": listWeekly![index].toString(),
        "reporting_cycle_id_monthly": listMonthly![index].toString(),
        "selected_day": 'Monday',
        "selected_time": '14:00:00',
        "format": 'csv'
      };
      reportList.add(watchList);
      index++;
    }
    EasyLoading.show(status: t.loading);
    Map data = {
      'data': reportList
          .map(
            (e) => e,
          )
          .toList(),
    };
    DioClient client = DioClient();
    final api2 = ReportProvider(client: client.init());
    api2.saveReport(data: data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        Utils.isCheck = true;
        Utils.snackBar(t.success_text, t.report_request_save_success_text);
        getEntityList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }
}
