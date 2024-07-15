import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class MaterialRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> materialListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.materialListApi);
    return response;
  }

  Future<dynamic> materialCategorieListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.materialCategoriesListApi);
    return response;
  }

  Future<dynamic> qualityTypeListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.qualityTypeApi);
    print('resresres: $response');
    return response;
  }


 }
