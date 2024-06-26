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
}
