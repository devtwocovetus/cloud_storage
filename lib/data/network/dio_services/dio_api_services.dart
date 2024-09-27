import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../../app_exceptions.dart';
import '../base_api_services.dart';

class DioApiServices extends BaseApiServices2{

  @override
  Future getApi(dio.Dio client,String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final dio.Response response = await client.get(url).timeout(const Duration(seconds: 600));
      responseJson = returnResponse(response);
      log("Mayur <><>422 responseJson ${responseJson.toString()}");
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on DioException catch (e) {
      log('Mayur <><>E : ${e.toString()}');
      if(e.response != null){
        responseJson = returnResponse(e.response!);
      }
    }
    log(responseJson.toString());
    return responseJson;
  }

  @override
  Future postApi(dio.Dio client,var data, String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try{
      dio.Response response = await client.post(url,data: json.encode(data))
          .timeout(const Duration(seconds: 600));
      responseJson = returnResponse(response);

    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on DioException catch (e) {
      log('Mayur <><>E : ${e.toString()}');
      if(e.response != null){
        responseJson = returnResponse(e.response!);
      }
    }
    if (kDebugMode) {
      print(responseJson);
      log('Mayur : ${responseJson.toString()}');
    }
    return responseJson;
  }

  @override
  Future putApi(dio.Dio client, data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }
    dynamic responseJson;
    try{
      dio.Response response = await client.put(url,data: json.encode(data))
          .timeout(const Duration(seconds: 600));
      responseJson = returnResponse(response);

    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on DioException catch (e) {
      log('Mayur <><>E : ${e.toString()}');
      if(e.response != null){
        responseJson = returnResponse(e.response!);
      }
    }
    if (kDebugMode) {
      print(responseJson);
      log('Mayur : ${responseJson.toString()}');
    }
    return responseJson;
  }

  dynamic returnResponse(dio.Response response) {
    switch (response.statusCode) {
      case 200:
        log("Mayur <><>200 ${response.data.toString()}");
        dynamic responseJson = response.data;
        return responseJson;
      case 201:
        log("Mayur <><>201 ${response.data.toString()}");
        dynamic responseJson = response.data;
        return responseJson;
      case 400:
        log("Mayur <><>400 ${response.data.toString()}");
        dynamic responseJson = response.data;
        return responseJson;

      case 401:
        {
          log("Mayur <><>401 ${response.data.toString()}");
          dynamic responseJson = response.data;
          Utils.isCheck = true;
          Utils.snackBar('Error','Session is expired or invalid need to login again');
          Get.offAllNamed(RouteName.loginView);
          return responseJson;
        }
      case 405:
        {
          log("Mayur <><>405 ${response.data.toString()}");
          dynamic responseJson = response.data;
          // Utils.isCheck = true;
          // Utils.snackBar('Error','Session is expired or invalid need to login again');
          // Get.offAllNamed(RouteName.loginView);
          return responseJson;
        }
      case 422:
        {
          log("Mayur <><>422 ${response.data.toString()}");
          dynamic responseJson = response.data;
          log("Mayur <><>2 ${responseJson.toString()}");
          Map validationRes = responseJson['data']['error'];
          String key = validationRes.keys.first;
          Utils.isCheck = true;
          Utils.snackBar('Error',validationRes[key][0]);
          return responseJson;
        }

      case 302:
        log("Mayur <><>302 ${response.data.toString()}");
        dynamic responseJson = response.data;
        return responseJson;

      case 500:
        log("Mayur <><>500 ${response.data.toString()}");
        dynamic responseJson = response.data;
        return responseJson;

      default:
        throw FetchDataException(
            'Error occurred while communicating with server ${response.statusCode}');
    }
  }

}