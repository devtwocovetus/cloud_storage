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
import 'package:cold_storage_flutter/i10n/strings.g.dart';

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
    if (kDebugMode) {
      print(responseJson);
    }
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
      log('update 111: ${response.statusCode}');
      log('update 111: ${response.body}');
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
  Future<dynamic> putApi(var data, String url) async {
    UserPreference userPreference = UserPreference();
    String? token = await userPreference.getUserToken();
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      final response = await http.put(Uri.parse(url), body: data, headers: {
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
      log('Mayur : ${response.body.toString()}');
      responseJson = returnResponse(response);
      log('Mayur : ${responseJson.toString()}');
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
      log('Mayur : ${responseJson.toString()}');
    }
    return responseJson;
  }

  @override
  Future<dynamic> deleteApi(String url) async {
    UserPreference userPreference = UserPreference();
    String? token = await userPreference.getUserToken();
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response = await http.delete(Uri.parse(url), headers: {
        "Authorization": "Bearer $token"
      }).timeout(const Duration(seconds: 100));
      log('Mayur : ${response.body.toString()}');
      responseJson = returnResponse(response);
      log('Mayur : ${responseJson.toString()}');
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
      log('Mayur : ${responseJson.toString()}');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) async {
    log("Response DAta 1: ${response.statusCode}");
    log("Response DAta 2: ${response.body}");
    UserPreference userPreference = UserPreference();
    switch (response.statusCode) {
      case 200:
        if (kDebugMode) {
          log(response.body);
        }
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 401:
        {
          dynamic responseJson = jsonDecode(response.body);
          Utils.isCheck = true;
          Utils.snackBar(
              t.error_text, t.session_expired_text);
          await userPreference.logout();
          Get.offAllNamed(RouteName.loginView);
          return responseJson;
        }

      case 422:
        {
          print("Mayur <><> ");
          print("Mayur <><> 1 ${response.statusCode}");
          print("Mayur <><> 2 ${response.body}");
          dynamic responseJson = jsonDecode(response.body);
          Map validationRes = responseJson['data']['error'];
          String key = validationRes.keys.first;
          Utils.isCheck = true;
          Utils.snackBar(t.error_text, validationRes[key][0]);
          return responseJson;
        }
      case 500:
        {
          log(response.body);
          dynamic responseJson = jsonDecode(response.body);
          Utils.snackBar(
              t.error_text, responseJson['data']['error'].toString());
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
