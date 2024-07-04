

import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';


class SignupRepository {
  final _apiService  = NetworkApiServices() ;

  Future<dynamic> signupApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.signupApi);
    return response ;
  }


 Future<dynamic> signupSendOtpApi(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.sendOtpApi);
    return response ;
  }

  




}