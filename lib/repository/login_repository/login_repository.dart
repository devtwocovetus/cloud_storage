

import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';


class LoginRepository {
  final _apiService  = NetworkApiServices() ;

  Future<dynamic> loginApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.loginApi);
    return response ;
  }

  Future<dynamic> createPasswordApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.changePasswordOnFirstLoginApi);
    print('response : $response');
    return response ;
  }

  Future<dynamic> logOutApi() async{
    dynamic response = await _apiService.getApi(AppUrl.logoutApi);
    return response ;
  }

}