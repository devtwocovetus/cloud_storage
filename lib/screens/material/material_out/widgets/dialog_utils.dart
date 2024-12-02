import 'package:cold_storage_flutter/i10n/strings.g.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

class DialogUtils {
  static final DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,
      {required String title,
      required String okBtnText,
      Color okBtnTextColor = const Color(0xff005AFF),
      required String cancelBtnText,
      required VoidCallback okBtnFunction,
      Widget? textFormField,
      }) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Color(0xffFF0000),
                fontWeight: FontWeight.w500,
                fontSize: 20.h,
              )),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.dialog_warning_message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                    fontSize: 20.h,
                  )),
                ),

                if(textFormField != null )...[
                  SizedBox(
                    height: 15.h,
                  ),
                  textFormField,
                  SizedBox(
                    height: 15.h,
                  ),
                ],
                // TextFormFieldLabel(
                //   padding: Utils.deviceWidth(context) * 0.04,
                //   lebelText: t.enter_new_password_label,
                //   lebelFontColor: const Color(0xff1A1A1A),
                //   obscure: _passwordUpdateViewModel.obscured.value,
                //   borderRadius: BorderRadius.circular(10.0),
                //   hint: t.enter_new_password_hint,
                //   controller: _passwordUpdateViewModel.passwordController.value,
                //   focusNode: _passwordUpdateViewModel.passwordFocusNode.value,
                //   textCapitalization: TextCapitalization.none,
                //   keyboardType: TextInputType.text,
                //   validating: (value) {
                //     if (value!.isEmpty ||
                //         !RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                //             .hasMatch(value)) {
                //       return '${t.password_validation_error}(@\$!%*?&)';
                //     }
                //     return null;
                //   },
                //   suffixIcon: Padding(
                //       padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                //       child: GestureDetector(
                //         onTap: _passwordUpdateViewModel.toggleObscured,
                //         child: Icon(
                //           _passwordUpdateViewModel.obscured.value
                //               ? Icons.visibility_off_rounded
                //               : Icons.visibility_rounded,
                //           size: 24.h,
                //         ),
                //       )
                //   ),
                // ),

              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyCustomButton(
                    textColor: const Color(0xffFFFFFF),
                    backgroundColor: okBtnTextColor,
                    width: App.appQuery.responsiveWidth(30) /*312.0*/,
                    height: 45.h,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: okBtnFunction,
                    text: okBtnText,
                  ),
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
      {required String title,
      required String okBtnText,
      required String cancelBtnText,
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
                color: Color(0xffFF0000),
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              )),
            ),
            content: Text(
              t.delete_confirmation,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Color(0xff000000),
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

  static void showMediaDialog(BuildContext context,
      {required String title,
      required String cameraBtnText,
      required String libraryBtnText,
      required VoidCallback cameraBtnFunction,
      required VoidCallback libraryBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Color(0xffFF0000),
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              )),
            ),
            content: Text(
              t.take_photo_from,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Color(0xff000000),
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
                    onPressed: cameraBtnFunction,
                    text: cameraBtnText,
                  ),
                  const Spacer(),
                  MyCustomButton(
                    textColor: const Color(0xffFFFFFF),
                    backgroundColor: const Color(0xff005AFF),
                    width: App.appQuery.responsiveWidth(30) /*312.0*/,
                    height: 45.h,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: libraryBtnFunction,
                    text: libraryBtnText,
                  ),
                ],
              ),
            ],
          );
        });
  }

 
}
