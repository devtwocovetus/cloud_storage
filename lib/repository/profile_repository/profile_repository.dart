import 'dart:developer';

import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class ProfileRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> profileUpdateApi(var data,String userId) async {
    dynamic response = await _apiService.putApi(data,'${AppUrl.updateProfile}/$userId');
    return response;
  }

  Future<dynamic> passwordUpdateApi(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.updatePassword);
    return response;
  }
}
