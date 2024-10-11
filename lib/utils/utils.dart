import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Utils {
  static bool isCheck = false;
  static Map<String, dynamic> decodedMap = {};
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
    if (text.isEmpty) {
      text = '';
    } else {
      text = text.toString().capitalize!;
    }
    return text;
  }

  static String dateFormate(String text) {
    if (text.isNotEmpty && text != 'null') {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      DateTime dateTime = DateTime.parse(text);
      text = formatter.format(dateTime);
    } else {
      text = 'NA';
    }
    return text;
  }

  static String dateFormateNotification(String text) {
    DateTime dateTime = DateTime.parse(text);
    if (text.isNotEmpty && text != 'null') {
      DateTime now = DateTime.now();
      text = timeago.format(dateTime, locale: 'en_short');
    } else {
      text = 'NA';
    }

    return text;
  }

  static String dateFormateNew(String text) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    DateTime dateTime = DateTime.parse(text);
    text = formatter.format(dateTime);
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
        titleText: Text(title,
        style: GoogleFonts.poppins(textStyle: TextStyle(color: kAppWhite,fontWeight: FontWeight.w400,fontSize: 16.0.sp)),
        ),
        messageText: Text(message,
          style: GoogleFonts.poppins(textStyle: TextStyle(color: kAppWhite,fontWeight: FontWeight.w400,fontSize: 14.0.sp)),
        )
      );
    }
  }

  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
}
