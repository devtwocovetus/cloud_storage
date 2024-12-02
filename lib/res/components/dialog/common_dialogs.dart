import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../i10n/strings.g.dart';

void showCustomWarningDialog({required String warningText}) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: kAppPrimary,size: 28.h,),
          SizedBox(width: 8.w),
          Text(
            t.dialog_img_limit_validation,
            style: TextStyle(
              color: kAppBlack87,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.dialog_upload_limit_warning,
            style: TextStyle(
              color: kAppBlack54,
              fontWeight: FontWeight.w500,
              fontSize: 17.sp,
            ),
          ),
          SizedBox(height: 8.w),
          Text(
            warningText,
            style: TextStyle(
              color: kAppBlack54,
              fontWeight: FontWeight.w500,
              fontSize: 17.sp,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: Text(
            t.dialog_cancel_btn_text,
              style: TextStyle(
                color: kAppGreyD,
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
              )
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(); // Perform further actions here if needed
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kAppPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(t.dialog_ok_text,
            style: TextStyle(
              color: kAppWhite,
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            )
          ),
        ),
      ],
    ),
    barrierDismissible: false, // Prevent dismissing by tapping outside
  );
}