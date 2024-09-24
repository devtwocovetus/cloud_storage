import 'package:cold_storage_flutter/data/network/dio_services/constant/app_url_dio.dart';
import 'package:cold_storage_flutter/data/network/dio_services/dio_api_services.dart';
import 'package:dio/dio.dart';

class MaterialOutProvider{
  Dio client;
  MaterialOutProvider({required this.client});

  final _apiServices = DioApiServices();

  Future<dynamic> entityToEntityTransferOut({var data}) async {
    dynamic response = await _apiServices.postApi(client,data,AppUrlDio.materialInternalTransfer);
    return response;
  }

}