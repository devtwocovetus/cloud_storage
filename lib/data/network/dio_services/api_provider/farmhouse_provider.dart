import 'package:cold_storage_flutter/data/network/dio_services/constant/app_url_dio.dart';
import 'package:cold_storage_flutter/data/network/dio_services/dio_api_services.dart';
import 'package:dio/dio.dart';

class FarmhouseProvider{
  Dio client;
  FarmhouseProvider({required this.client});

  final _apiServices = DioApiServices();

  Future<dynamic> managerListApi() async {
    dynamic response = await _apiServices.getApi(client,'${AppUrlDio.userListApi}?role_id=3');
    return response;
  }

  Future<dynamic> addFarmhouseApi({var data}) async {
    dynamic response = await _apiServices.postApi(client,data,AppUrlDio.addFarmhouseApi);
    return response;
  }

  Future<dynamic> updateFarmhouseApi({var data,required int id}) async {
    dynamic response = await _apiServices.putApi(client,data,'${AppUrlDio.updateFarmhouseApi}/$id');
    return response;
  }

}