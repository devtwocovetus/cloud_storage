import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../view_models/forgot_password/reset_password_view_model.dart';
import '../../i10n/strings.g.dart' as i18n;

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  final _formKey = GlobalKey<FormState>();
  final ResetPasswordViewModel _resetPasswordViewModel = Get.put(ResetPasswordViewModel());
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
                _resetPasswordViewModel.resetPassword()
              }
          },
          text: translation.change_password_text,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
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
                        height: 15,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.reset_password_text,
                        fontSize: 18.0,
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
                child: Obx(()=>
                  Column(
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
                            text: translation.verification_code_prompt,
                            isMultyline: true,
                            line: 2,
                            fontSize: 17.0,
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
                            text: translation.verification_code_info,
                            isMultyline: true,
                            line: 3,
                            fontSize: 15.0,
                            fontColor: kAppBlack60,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(
                        height: Utils.deviceHeight(context) * 0.03,
                      ),
                      TextFormFieldLabel(
                        padding: Utils.deviceWidth(context) * 0.04,
                        lebelText: translation.enter_otp_label,
                        lebelFontColor: const Color(0xff1A1A1A),
                        borderRadius: BorderRadius.circular(10.0),
                        hint: translation.enter_otp_hint,
                        controller: _resetPasswordViewModel.otpController.value,
                        focusNode: _resetPasswordViewModel.otpFocusNode.value,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.number,
                        validating: (value) {
                          if (value!.isEmpty || value.length<6) {
                            return translation.otp_validation_error;
                          }
                          return null;
                        },),
                      SizedBox(
                        height: Utils.deviceHeight(context) * 0.03,
                      ),

                      TextFormFieldLabel(
                        padding: Utils.deviceWidth(context) * 0.04,
                        lebelText: translation.enter_new_password,
                        lebelFontColor: const Color(0xff1A1A1A),
                        obscure: _resetPasswordViewModel.obscured.value,
                        borderRadius: BorderRadius.circular(10.0),
                        hint: translation.enter_new_password_hint,
                        controller: _resetPasswordViewModel.passwordController.value,
                        focusNode: _resetPasswordViewModel.passwordFocusNode.value,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.text,
                        validating: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                                  .hasMatch(value)) {
                            return '${translation.password_validation}(@\$!%*?&)';
                          }
                          return null;
                        },
                        suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _resetPasswordViewModel.toggleObscured,
                              child: Icon(
                                _resetPasswordViewModel.obscured.value
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                size: 24,
                              ),
                            )
                        ),
                      ),
                      SizedBox(
                        height: Utils.deviceHeight(context) * 0.02,
                      ),
                      TextFormFieldLabel(
                        padding: Utils.deviceWidth(context) * 0.04,
                        lebelText: translation.re_enter_your_password,
                        lebelFontColor: const Color(0xff1A1A1A),
                        obscure: _resetPasswordViewModel.obscuredConfirm.value,
                        borderRadius: BorderRadius.circular(10.0),
                        hint: translation.re_enter_your_password,
                        controller: _resetPasswordViewModel.conPasswordController.value,
                        focusNode: _resetPasswordViewModel.conPasswordFocusNode.value,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.text,
                        validating: (value) {
                          if (value!.isEmpty ||
                              value.compareTo(
                                  _resetPasswordViewModel.passwordController.value.text) !=
                                  0) {
                            return translation.passwords_do_not_match;
                          }
                          return null;
                        },
                        suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _resetPasswordViewModel.toggleConfirmObscured,
                              child: Icon(
                                _resetPasswordViewModel.obscuredConfirm.value
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                size: 24,
                              ),
                            )
                        ),
                      ),
                      SizedBox(
                        height: Utils.deviceHeight(context) * 0.03,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )
            ),
          )
      ),
    );
  }
}
