import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class ClientRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> timeZonesApi() async {
    dynamic response = await _apiService.getApi(AppUrl.timeZoneApi);
    return response;
  }

  Future<dynamic> getClient() async {
    dynamic response = await _apiService.getApi(AppUrl.createListApi);
    return response;
  }

  Future<dynamic> createClientApi(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.createClientApi);
    return response;
  }
}
