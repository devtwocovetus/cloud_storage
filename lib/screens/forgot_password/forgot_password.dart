import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/forgot_password/forgot_password_view_model.dart';
import '../../i10n/strings.g.dart' as i18n;

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final _formKey = GlobalKey<FormState>();
  final ForgotPasswordViewModel _forgotPasswordViewModel = Get.put(ForgotPasswordViewModel());
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    translation = i18n.Translations.of(context);
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !showFab,
        child: MyCustomButton(
          width: App.appQuery.responsiveWidth(70),
          height: Utils.deviceHeight(context) * 0.06,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            Utils.isCheck = true,
            if (_formKey.currentState!.validate())
              {
                // Get.offAllNamed(RouteName.resetPassword,arguments: {
                //   'user_email' : _forgotPasswordViewModel.emailController.value.text.toString()
                // })
                _forgotPasswordViewModel.submitForEmail()
              }
          },
          text: translation.submit,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: SafeArea(
            child: Container(
              height: 60.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        height: 15.h,
                        width: 10.h,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.forgot_password_title,
                        fontSize: 18.0.sp,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.03,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/forgot_password_img.png',
                        fit: BoxFit.cover,
                        height: Utils.deviceHeight(context) * 0.3,
                      ),
                    ),
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Utils.deviceWidth(context) * 0.04),
                      child: CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.registered_email_prompt,
                        isMultyline: true,
                        line: 2,
                        fontSize: 17.0.sp,
                        fontColor: kAppBlack,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Utils.deviceWidth(context) * 0.04,
                        vertical: 4
                      ),
                      child: CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.registered_email_prompt_desc_text,
                        isMultyline: true,
                        line: 3,
                        fontSize: 15.0.sp,
                        fontColor: kAppBlack60,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.03,
                    ),
                    TextFormFieldLabel(
                      lebelText: translation.email,
                      lebelFontColor: const Color(0xff1A1A1A),
                      padding: Utils.deviceWidth(context) * 0.04,
                      borderRadius: BorderRadius.circular(10.0),
                      hint: translation.email_hint,
                      controller: _forgotPasswordViewModel.emailController.value,
                      focusNode: _forgotPasswordViewModel.emailFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return translation.email_validation_error;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny( RegExp(r'\s')),
                      ],
                    ),
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.03,
                    ),
                  ],
                )
            ),
          )
      ),
    );
  }
}
