import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class AccountRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> timeZonesApi() async {
    dynamic response = await _apiService.getApi(AppUrl.timeZoneApi);
    return response;
  }

  Future<dynamic> unitApi() async {
    dynamic response = await _apiService.getApi(AppUrl.unitsApi);
    return response;
  }

  Future<dynamic> getAccountDetails() async {
    dynamic response = await _apiService.getApi(AppUrl.unitsApi);
    return response;
  }

  Future<dynamic> accountSubmitApi(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.accountSubmitApi);
    return response;
  }
    Future<dynamic> accountUpdateApi(var data,String userId) async {
    dynamic response = await _apiService.postWithTokenApi(data,'${AppUrl.accountSubmitApi}/$userId');
    return response;
  }
}
