import 'package:cold_storage_flutter/data/network/dio_services/constant/app_url_dio.dart';
import 'package:dio/dio.dart';

import '../dio_api_services.dart';

class AssignedProvider{

  Dio client;
  AssignedProvider({required this.client});

  final _apiServices = DioApiServices();


  Future<dynamic> userAssigned({var data}) async {
    dynamic response = await _apiServices.postApi(client,data,AppUrlDio.addEntityUserRelation);
    return response;
  }

}