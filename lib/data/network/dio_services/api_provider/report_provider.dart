import 'package:cold_storage_flutter/data/network/dio_services/constant/app_url_dio.dart';
import 'package:dio/dio.dart';

import '../dio_api_services.dart';

class ReportProvider{

  Dio client;
  ReportProvider({required this.client});

  final _apiServices = DioApiServices();


  Future<dynamic> saveReport({var data}) async {
    dynamic response = await _apiServices.postApi(client,data,AppUrlDio.addEntityReportingCycleRelation);
    return response;
  }

}