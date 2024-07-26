import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Utils {
  static bool isCheck = false;
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: blackColor,
      textColor: whiteColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static toastMessageCenter(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: blackColor,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      textColor: whiteColor,
    );
  }

  static String textCapitalizationString(String text) {
   if(text.isEmpty){
   text = '';
   }else{ 
    text = text.toString().capitalize!;
   }
   return text;
  }

  static snackBar(String title, String message) {
    if (isCheck) {
      isCheck = false;
      Get.snackbar(
        colorText: const Color(0xffffffff),
        backgroundColor: const Color(0xff0E64D1),
        title,
        message,
      );
    }
  }
  static double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

static double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
}
