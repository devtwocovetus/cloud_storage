import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class UserRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> userRoleListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.userRoleListApi);
    return response;
  }

 }
