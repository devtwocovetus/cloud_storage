import 'package:cold_storage_flutter/data/network/dio_services/constant/app_url_dio.dart';
import 'package:dio/dio.dart';

import '../dio_api_services.dart';

class MaterialUpdateInProvider{

  Dio client;
  MaterialUpdateInProvider({required this.client});

  final _apiServices = DioApiServices();

  Future<dynamic> transactionMasterDetailsWithMaterialUpdateIn({var data,required String transactionId}) async {
    dynamic response = await _apiServices.putApi(client,data,'${AppUrlDio.transactionMasterDetailsWithMaterialUpdate}/$transactionId');
    return response;
  }

}