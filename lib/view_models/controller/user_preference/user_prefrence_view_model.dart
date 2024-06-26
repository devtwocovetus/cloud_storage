


import 'package:cold_storage_flutter/models/login/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {

    Future<bool> saveUser(LoginModel responseModel)async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('token', responseModel.data?.token.toString() ?? '');
      sp.setInt('id', responseModel.data?.id ?? 0);
      sp.setString('name', responseModel.data?.name ?? '');
      sp.setString('email', responseModel.data?.email ?? '');
      sp.setInt('role', responseModel.data?.role ?? 0);
      sp.setBool('accountExist', responseModel.data?.accountExist ?? false);
      sp.setBool('isLogin', true);

      return true ;
    }

    Future<String?> getUserToken() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('token');
      return token;
    }

    Future<bool?> getUserIsLogin()async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      bool? isLogin = sp.getBool('isLogin');
      return isLogin;
    }

    Future<bool> removeUser()async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.clear();
      return true ;
    }
}