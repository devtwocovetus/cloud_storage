import 'package:cold_storage_flutter/data/network/dio_services/constant/app_url_dio.dart';
import 'package:cold_storage_flutter/data/network/dio_services/dio_api_services.dart';
import 'package:dio/dio.dart';

class WarehouseProvider{
  Dio client;
  WarehouseProvider({required this.client});

  final _apiServices = DioApiServices();

  Future<dynamic> managerListApi() async {
    dynamic response = await _apiServices.getApi(client,'${AppUrlDio.userListApi}?role_id=3');
    return response;
  }

  Future<dynamic> storageTypeListApi() async {
    dynamic response = await _apiServices.getApi(client,AppUrlDio.storageTypeListApi);
    return response;
  }

  Future<dynamic> addColdStorageApi({var data}) async {
    dynamic response = await _apiServices.postApi(client,data,AppUrlDio.addColdStorageApi);
    return response;
  }

  Future<dynamic> updateColdStorageApi({var data,required int id}) async {
    dynamic response = await _apiServices.putApi(client,data,'${AppUrlDio.updateWarehouseApi}/$id');
    return response;
  }

}