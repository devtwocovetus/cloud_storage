


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
      sp.setInt('current_account_status', responseModel.data?.currentAccountStatus ?? 0);
      sp.setBool('isLogin', true);

      return true ;
    }

    Future<bool> updateCurrentAccountStatus(int status)async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setInt('current_account_status', status);
      return true ;
    }

    Future<bool> saveLogo(String logoUrl)async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('logo_url', logoUrl);
      return true ;
    }

    Future<int?> getCurrentAccountStatus() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      int? token = sp.getInt('current_account_status') ?? 0;
      return token;
    }

    Future<String?> getUserToken() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('token');
      return token;
    }

    Future<String?> getLogo() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('logo_url');
      return token;
    }

    
    Future<String?> getUserEmail() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('email');
      return token;
    }

    
    Future<String?> getUserName() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('name');
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