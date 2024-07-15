import 'dart:developer';

import 'package:cold_storage_flutter/res/app_url/app_url.dart';
import 'package:dio/dio.dart';
import '../../../view_models/controller/user_preference/user_prefrence_view_model.dart';


class DioClient {
  Dio init({bool withToken = true}) {
    Dio dio = Dio();
    dio.interceptors.add(ApiInterceptors(withToken: withToken));
    dio.options.baseUrl = AppUrl.baseUrl;
    return dio;
  }
}

class ApiInterceptors extends Interceptor {
  ApiInterceptors({required this.withToken});

  final bool withToken;
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);

    UserPreference userPreference = UserPreference();
    String? token = await userPreference.getUserToken();
    log('Mayur :: $token');
    options.headers["Content-Type"] = 'application/json';
    if (token != "" && withToken) {
      options.headers["Authorization"] = "Bearer $token";
    }
  }
}
