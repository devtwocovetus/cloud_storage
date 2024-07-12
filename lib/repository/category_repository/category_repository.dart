import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class CategoryRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> addCategory(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.categoryAddApi);
    return response;
  }
 }
