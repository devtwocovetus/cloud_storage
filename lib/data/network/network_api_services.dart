import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cold_storage_flutter/data/network/base_api_services.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    UserPreference userPreference = UserPreference();
    String? token = await userPreference.getUserToken();
    print('###<><> $token');

    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer $token"
      }).timeout(const Duration(seconds: 100));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    print(responseJson);
    return responseJson;
  }

  @override
  Future<dynamic> postWithTokenApi(var data, String url) async {
    UserPreference userPreference = UserPreference();
    String? token = await userPreference.getUserToken();
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: data, headers: {
        "Authorization": "Bearer $token"
      }).timeout(const Duration(seconds: 100));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 100));
      log('Mayur : ${response.body}');
      responseJson = returnResponse(response);
      log('Mayur : $responseJson');

    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
      log('Mayur : $responseJson');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 401:
        {
          dynamic responseJson = jsonDecode(response.body);
           Utils.isCheck = true;
           Utils.snackBar('Error','Session is expired or invalid need to login again');
           Get.offAllNamed(RouteName.loginView);
          return responseJson;
        }

      case 422:
        {
          print("Mayur <><>");
          dynamic responseJson = jsonDecode(response.body);
          Map validationRes = responseJson['data']['error'];
          String key = validationRes.keys.first;
          Utils.isCheck = true;
          Utils.snackBar('Error',validationRes[key][0]);
          return responseJson;
        }

      case 302:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      default:
        throw FetchDataException(
            'Error occurred while communicating with server ${response.statusCode}');
    }
  }
}
