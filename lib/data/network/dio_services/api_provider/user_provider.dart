import 'package:cold_storage_flutter/data/network/dio_services/constant/app_url_dio.dart';
import 'package:cold_storage_flutter/data/network/dio_services/dio_api_services.dart';
import 'package:dio/dio.dart';

class UserProvider{
  Dio client;
  UserProvider({required this.client});

  final _apiServices = DioApiServices();


  // Future<dynamic> userRoleListApi() async {
  //   dynamic response = await _apiServices.getApi(client,AppUrlDio.userRoleListApi);
  //   return response;
  // }

  // Future<dynamic> createUserApi(var data) async {
  //   dynamic response = await _apiServices.postWithTokenApi(data,AppUrl.addUserApi);
  //   return response;
  // }

  Future<dynamic> updateUserApi({
    var data,
    required int userId
  }) async {
    dynamic response = await _apiServices.putApi(client,data,'${AppUrlDio.updateUserApi}/$userId');
    return response;
  }

  // Future<dynamic> userListApi() async {
  //   dynamic response = await _apiServices.getApi(AppUrl.userListApi);
  //   return response;
  // }
  //
  // Future<dynamic> userDelete(String userId) async {
  //   dynamic response = await _apiServices.deleteApi('${AppUrl.deleteUser}$userId');
  //   return response;
  // }

}