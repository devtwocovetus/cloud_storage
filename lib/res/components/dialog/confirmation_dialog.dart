import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

class ConfirmationDialog {
  static final ConfirmationDialog _instance = ConfirmationDialog.internal();

  ConfirmationDialog.internal();

  factory ConfirmationDialog() => _instance;

  static void showCustomDialog(BuildContext context,
      {required String title,
        required String okBtnText,
        required String cancelBtnText,
        required String dialogMessage,
        required VoidCallback okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0xffFF0000),
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
            ),
            content: Text(
              dialogMessage,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
            ),
            actions: <Widget>[
              Row(
                children: [
                  MyCustomButton(
                    textColor: const Color(0xff000000),
                    backgroundColor: const Color(0xffD9D9D9),
                    width: App.appQuery.responsiveWidth(30) /*312.0*/,
                    height: 45,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: cancelBtnText,
                  ),
                  const Spacer(),
                  MyCustomButton(
                    textColor: const Color(0xffFFFFFF),
                    backgroundColor: const Color(0xff005AFF),
                    width: App.appQuery.responsiveWidth(30) /*312.0*/,
                    height: 45,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: okBtnFunction,
                    text: okBtnText,
                  ),
                ],
              ),
            ],
          );
        });
  }
}
