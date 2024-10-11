import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

class DialogUtils {
  static final DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,
      {String title = 'Warning',
      String okBtnText = "Proceed",
      String cancelBtnText = "Cancel",
      required VoidCallback okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: const Color(0xffFF0000),
                fontWeight: FontWeight.w500,
                fontSize: 20.h,
              )),
            ),
            content: Text(
              'This is an irreversible action. Do you want to proceed?',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle:  TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w500,
                fontSize: 20.h,
              )),
            ),
            actions: <Widget>[
              Row(
                children: [
                  MyCustomButton(
                    textColor: const Color(0xffFFFFFF),
                    backgroundColor: const Color(0xff005AFF),
                    width: App.appQuery.responsiveWidth(30) /*312.0*/,
                    height: 45.h,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: okBtnFunction,
                    text: okBtnText,
                  ),
                  const Spacer(),
                  MyCustomButton(
                    textColor: const Color(0xff000000),
                    backgroundColor: const Color(0xffD9D9D9),
                    width: App.appQuery.responsiveWidth(30) /*312.0*/,
                    height: 45.h,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: cancelBtnText,
                  ),
                ],
              ),
            ],
          );
        });
  }

  static void showDeleteConfirmDialog(BuildContext context,
      {String title = 'Alert',
      String okBtnText = "Yes",
      String cancelBtnText = "No",
      required VoidCallback okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: const Color(0xffFF0000),
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              )),
            ),
            content: Text(
              'Are you sure you want to delete this?',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              )),
            ),
            actions: <Widget>[
              Row(
                children: [
                  MyCustomButton(
                    textColor: const Color(0xffFFFFFF),
                    backgroundColor: const Color(0xff005AFF),
                    width: App.appQuery.responsiveWidth(30) /*312.0*/,
                    height: 45.h,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: okBtnFunction,
                    text: okBtnText,
                  ),
                  const Spacer(),
                  MyCustomButton(
                    textColor: const Color(0xff000000),
                    backgroundColor: const Color(0xffD9D9D9),
                    width: App.appQuery.responsiveWidth(30) /*312.0*/,
                    height: 45.h,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: cancelBtnText,
                  ),
                ],
              ),
            ],
          );
        });
  }
}
