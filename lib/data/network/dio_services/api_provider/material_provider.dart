import 'package:cold_storage_flutter/data/network/dio_services/constant/app_url_dio.dart';
import 'package:dio/dio.dart';

import '../dio_api_services.dart';

class MaterialProvider{

  Dio client;
  MaterialProvider({required this.client});

  final _apiServices = DioApiServices();

  Future<dynamic> qualityTypeListApi() async {
    dynamic response = await _apiServices.getApi(client,AppUrlDio.qualityTypeApi);
    return response;
  }

  Future<dynamic> addMaterialUnit({var data}) async {
    dynamic response = await _apiServices.postApi(client,data,AppUrlDio.addMaterialUnitApi);
    return response;
  }

  Future<dynamic> updateMaterialUnit({var data, required int id}) async {
    dynamic response = await _apiServices.putApi(client,data,'${AppUrlDio.updateMaterialUnitApi}/$id');
    return response;
  }

  Future<dynamic> addMaterialIn({var data}) async {
    dynamic response = await _apiServices.postApi(client,data,AppUrlDio.addMaterialInApi);
    return response;
  }

  Future<dynamic> addMaterialOut({var data}) async {
    dynamic response = await _apiServices.postApi(client,data,AppUrlDio.addMaterialOutApi);
    return response;
  }

}