import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class EntityRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> entityListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.entityListApi);
    return response;
  }


 }
