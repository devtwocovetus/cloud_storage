import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class UserRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> userRoleListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.userRoleListApi);
    return response;
  }

 Future<dynamic> createUserApi(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.addUserApi);
    return response;
  }

  Future<dynamic> userListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.userListApi);
    return response;
  }

  Future<dynamic> userDelete(String userId) async {
    dynamic response = await _apiService.deleteApi('${AppUrl.deleteUser}$userId');
    return response;
  }

 }
