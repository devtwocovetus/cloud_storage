import 'package:cold_storage_flutter/data/network/dio_services/dio_api_services.dart';
import 'package:dio/dio.dart';


class WarehouseProvider{
  Dio client;
  WarehouseProvider({required this.client});

  final _apiServices = DioApiServices();

  Future<dynamic> addColdStorageApi({var data}) async {
    dynamic response = await _apiServices.postApi(client,data,'/api/cold-storage');
    return response;
  }

}